const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

    this.after('READ', 'Books', (books) => {
        books = Array.isArray(books) ? books : [books];

        for (const b of books) {

            if (!b) continue;

            if (b.availableCopies === 0) {
                b.stockCriticality = 1; // Red
            }
            else if (b.availableCopies < 5) {
                b.stockCriticality = 2; // Orange
            }
            else {
                b.stockCriticality = 3; // Green
            }
        }
    });

});