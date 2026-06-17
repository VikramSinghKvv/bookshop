"use strict";

/**
 * ReportingService Handler
 * Serves read-only projections over pre-built CDS views.
 *
 * Registered path : /reports
 * Entities exposed:
 *   - AvailableBooks      – books with stock in hand
 *   - OverdueBorrowings   – borrowings past their due date
 *   - BookPricing         – price tiers + GST breakdown
 *   - MemberActivity      – member profile snapshot
 */
module.exports = class ReportingService extends cds.ApplicationService {

  async init() {

    // ── AvailableBooks ───────────────────────────────────────────────────
    /**
     * Optionally inject stockCriticality at read time.
     * CAP marks it @Core.Computed in the schema, so the DB won't store it;
     * we compute it here based on availableCopies.
     *
     * Criticality values (SAP Fiori convention):
     *   0 = Neutral  |  1 = Error (red)  |  2 = Warning (amber)  |  3 = Success (green)
     */
    this.after('READ', 'AvailableBooks', (books) => {
      if (!Array.isArray(books)) books = [books];
      books.forEach(book => {
        if (book.availableCopies == null) return;
        if (book.availableCopies === 0)       book.stockCriticality = 1; // Error
        else if (book.availableCopies <= 3)   book.stockCriticality = 2; // Warning
        else                                   book.stockCriticality = 3; // Success
      });
    });

    // ── OverdueBorrowings ────────────────────────────────────────────────
    /**
     * Dynamically calculate fine amount when the record is read.
     * Fine rule: ₹5 per day overdue (only applied if fineAmount is 0 / null).
     */
    this.after('READ', 'OverdueBorrowings', (borrowings) => {
      if (!Array.isArray(borrowings)) borrowings = [borrowings];
      const today = new Date();

      borrowings.forEach(b => {
        if (!b.dueDate) return;
        const due = new Date(b.dueDate);
        const overdueDays = Math.max(0, Math.floor((today - due) / 86_400_000));

        // Only override if the stored value is missing / zero
        if (!b.fineAmount && overdueDays > 0) {
          b.fineAmount = +(overdueDays * 5).toFixed(2); // ₹5/day
        }
        // Attach a human-readable overdue label
        b.overdueDays = overdueDays;
      });
    });

    // ── BookPricing ──────────────────────────────────────────────────────
    /**
     * No runtime enrichment needed – all calculated columns are handled
     * inside the CDS view (memberPrice, gstAmount, priceWithGST, priceCategory).
     * Add custom logic here if pricing rules ever become dynamic.
     */

    // ── MemberActivity ───────────────────────────────────────────────────
    /**
     * Mask the email domain for inactive members before returning.
     * Active members see full email; inactive members see  j***@***.com style.
     */
    this.after('READ', 'MemberActivity', (members) => {
      if (!Array.isArray(members)) members = [members];
      members.forEach(m => {
        if (!m.isActive && m.email) {
          const [local, domain] = m.email.split('@');
          m.email = `${local[0]}***@***.${domain?.split('.').pop() ?? 'com'}`;
        }
      });
    });

    // ── Error handling helper ────────────────────────────────────────────
    this.on('error', (err, _req) => {
      // Normalise database-level errors into readable OData error responses
      if (err.code === 'SQLITE_ERROR' || err.code === 'ERR_DB') {
        err.message = `Database error in ReportingService: ${err.message}`;
        err.status  = 500;
      }
    });

    // Always call super so CAP wires up the remaining CRUD machinery
    return super.init();
  }
};