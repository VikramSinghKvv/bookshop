using CatalogService as service from './../../srv/catalog-service';

annotate service.Books with @(
    UI.HeaderInfo : {
        TypeName : 'Book',
        TypeNamePlural : 'Books',
        Title : {
            Value : title
        }
    },

    UI.SelectionFields : [
        title,
        isbn,
        language
    ],

    UI.LineItem : [
        {
            Value : title,
            Label : 'Title'
        },
        {
            Value : isbn,
            Label : 'ISBN'
        },
        {
            Value : language,
            Label : 'Language'
        },
        {
            Value : price,
            Label : 'Price'
        },
        {
            Value : availableCopies,
            Label : 'Available Copies'
        }
    ]
);

annotate service.Books with {
    title           @title : 'Book Title';
    isbn            @title : 'ISBN';
    language        @title : 'Language';
    price           @title : 'Price';
    pages           @title : 'Pages';
    edition         @title : 'Edition';
    totalCopies     @title : 'Total Copies';
    availableCopies @title : 'Available Copies';
};