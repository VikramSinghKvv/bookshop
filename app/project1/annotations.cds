using CatalogService as service from '../../srv/catalog-service';
annotate service.Books with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'isbn',
                Value : isbn,
            },
            {
                $Type : 'UI.DataField',
                Label : 'pages',
                Value : pages,
            },
            {
                $Type : 'UI.DataField',
                Label : 'price',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'publishedDate',
                Value : publishedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'language',
                Value : language,
            },
            {
                $Type : 'UI.DataField',
                Label : 'edition',
                Value : edition,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalCopies',
                Value : totalCopies,
            },
            {
                $Type : 'UI.DataField',
                Label : 'availableCopies',
                Value : availableCopies,
            },
            {
                $Type : 'UI.DataField',
                Label : 'summary',
                Value : summary,
            },
            {
                $Type : 'UI.DataField',
                Label : 'genre_code',
                Value : genre_code,
            },
            {
                $Type : 'UI.DataField',
                Value : author.birthDate,
                Label : 'birthDate',
            },
            {
                $Type : 'UI.DataField',
                Value : author.firstName,
                Label : 'firstName',
            },
            {
                $Type : 'UI.DataField',
                Value : author.ID,
                Label : 'ID',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'authorsDetails',
            ID : 'authorsDetails',
            Target : '@UI.FieldGroup#authorsDetails',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'title',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Label : 'isbn',
            Value : isbn,
        },
        {
            $Type : 'UI.DataField',
            Label : 'pages',
            Value : pages,
        },
        {
            $Type : 'UI.DataField',
            Label : 'price',
            Value : price,
        },
        {
            $Type : 'UI.DataField',
            Label : 'publishedDate',
            Value : publishedDate,
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Books',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View 1',
    },
    UI.FieldGroup #authorDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.FieldGroup #authorsDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : author.ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : author.firstName,
                Label : 'firstName',
            },
            {
                $Type : 'UI.DataField',
                Value : author.lastName,
                Label : 'lastName',
            },
            {
                $Type : 'UI.DataField',
                Value : author.nationality,
                Label : 'nationality',
            },
            {
                $Type : 'UI.DataField',
                Value : author.isActive,
                Label : 'isActive',
            },
            {
                $Type : 'UI.DataField',
                Value : author.email,
                Label : 'email',
            },
        ],
    },
);

annotate service.Books with {
    author @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Authors',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : author_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'firstName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'lastName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'nationality',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'birthDate',
            },
        ],
    }
};

annotate service.Books with {
    genre @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Genres',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : genre_code,
                ValueListProperty : 'code',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'description',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'isActive',
            },
        ],
    }
};
// annotate CatalogService.Books with @(
//   UI.LineItem : [
//     {
//       $Type : 'UI.DataField',
//       Value : availableCopies,
//       Criticality : stockCriticality,
//       CriticalityRepresentation : #WithIcon
//     }
//   ]
// );

annotate CatalogService.Books with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title
        },
        {
            $Type : 'UI.DataField',
            Value : isbn
        },
        {
            $Type : 'UI.DataField',
            Value : pages
        },
        {
            $Type : 'UI.DataField',
            Value : price
        },
        {
            $Type : 'UI.DataField',
            Value : publishedDate
        },
        {
            $Type : 'UI.DataField',
            Value : availableCopies,
            Criticality : stockCriticality,
            CriticalityRepresentation : #WithIcon
        }
    ]
);


    

annotate service.Borrowings with @(
    UI.Facets : [
        
    ],
    UI.FieldGroup #cost : {
        $Type : 'UI.FieldGroupType',
        Data : [
            
        ],
    },
    UI.FieldGroup #borrowingdetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.book_ID,
                Label : 'book_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.borrowDate,
                Label : 'borrowDate',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.fineAmount,
                Label : 'fineAmount',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.dueDate,
                Label : 'dueDate',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.member_ID,
                Label : 'member_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.returnDate,
                Label : 'returnDate',
            },
            {
                $Type : 'UI.DataField',
                Value : book.borrowings.status,
                Label : 'status',
            },
        ],
    },
    UI.FieldGroup #authors : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
);

annotate service.Reviews with @(
    UI.LineItem #authorsDetails1 : [
    ]
);

annotate service.Authors with @(
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Authors',
    },
);

