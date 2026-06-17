const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

    // ── AvailableBooks ───────────────────────────────────────────────────
    this.after('READ', 'AvailableBooks', async (books) => {
        books = Array.isArray(books) ? books : [books];

        for (const book of books) {
            if (!book) continue;

            // Stock criticality based on availableCopies
            if (book.availableCopies === 0) {
                book.stockCriticality = 1; // Red
            } else if (book.availableCopies <= 3) {
                book.stockCriticality = 2; // Orange
            } else {
                book.stockCriticality = 3; // Green
            }

            // Average rating from Reviews
            const reviews = await SELECT.from('lib.management.Reviews')
                .where({ book_ID: book.ID });

            book.totalReviews = reviews.length;
            book.averageRating = reviews.length
                ? +(reviews.reduce((sum, r) => sum + r.rating, 0) / reviews.length).toFixed(1)
                : 0.0;
        }
    });

    // ── OverdueBorrowings ────────────────────────────────────────────────
    this.after('READ', 'OverdueBorrowings', (borrowings) => {
        borrowings = Array.isArray(borrowings) ? borrowings : [borrowings];

        const today = new Date();

        for (const b of borrowings) {
            if (!b || !b.dueDate) continue;

            const due = new Date(b.dueDate);
            const overdueDays = Math.max(0, Math.floor((today - due) / 86_400_000));

            b.overdueDays = overdueDays;

            // Fine: ₹5 per day, only if not already set
            if (!b.fineAmount && overdueDays > 0) {
                b.fineAmount = +(overdueDays * 5).toFixed(2);
            }
        }
    });

    // ── MemberActivity ───────────────────────────────────────────────────
    this.after('READ', 'MemberActivity', (members) => {
        members = Array.isArray(members) ? members : [members];

        for (const m of members) {
            if (!m) continue;

            // Mask email for inactive members
            if (!m.isActive && m.email) {
                const [local, domain] = m.email.split('@');
                m.email = `${local[0]}***@***.${domain?.split('.').pop() ?? 'com'}`;
            }
        }
    });

    // ── AuthorSummary ────────────────────────────────────────────────────
    this.after('READ', 'AuthorSummary', async (authors) => {
    authors = Array.isArray(authors) ? authors : [authors];

    for (const author of authors) {
        if (!author) continue;

        // Get all books by this author
        const books = await SELECT.from('lib.management.Books')
            .where({ author_ID: author.ID });

        author.totalBooks = books.length;

        // Average of all book ratings
        const rated = books.filter(b => b.averageRating > 0);
        author.authorRating = rated.length
            ? +(rated.reduce((sum, b) => sum + b.averageRating, 0) / rated.length).toFixed(1)
            : 0.0;
    }
    });

});
