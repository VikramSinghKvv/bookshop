namespace lib.management;

// ───────────────── TYPES ─────────────────
type Name   : String(100);
type Email  : String(255);
type Phone  : String(20);
type Amount : Decimal(10,2);

type BorrowStatus : String(20) enum {
  Borrowed;
  Returned;
  Overdue;
}

// ───────────────── AUTHORS ─────────────────
entity Authors {
  key ID          : UUID;
  firstName       : String(50);
  lastName        : String(50);
  nationality     : String(50);
  birthDate       : Date;
  biography       : String(1000);
  email           : Email;
  isActive        : Boolean;

  // IMPORTANT: inverse association (OData-safe)
  books           : Association to many Books on books.author = $self;
  authorRating      : Decimal(3,1);    // avg across all their books
  totalBooks        : Integer;         // count of books published
}

// ───────────────── GENRES ─────────────────
entity Genres {
  key code        : String(20);
  name            : String(50);
  description     : String(200);
  isActive        : Boolean;

  books           : Association to many Books on books.genre = $self;
}

// ───────────────── BOOKS ─────────────────
entity Books {
  key ID            : UUID;

  title             : String(200);
  isbn              : String(13);
  pages             : Integer;
  price             : Amount;
  publishedDate     : Date;
  language          : String(30);
  edition           : Integer;
  totalCopies       : Integer default 100;
  availableCopies   : Integer;
  summary           : String(2000);

  // IMPORTANT: keep FK implicit (CAP will generate author_ID, genre_code)
  author            : Association to Authors;
  genre             : Association to Genres;

  reviews           : Association to many Reviews on reviews.book = $self;
  borrowings        : Association to many Borrowings on borrowings.book = $self;
  stockCriticality    : Integer @Core.Computed;
  averageRating     : Decimal(3,1);    // e.g. 4.5
  totalReviews      : Integer;         // computed count of reviews

}

// ───────────────── MEMBERS ─────────────────
entity Members {
  key ID            : UUID;

  memberNumber      : String(10);
  firstName         : String(50);
  lastName          : String(50);
  email             : Email;
  phone             : Phone;
  address           : String(200);

  joinDate          : Date;
  memberType        : String(20);
  maxBooks          : Integer;
  isActive          : Boolean;

  borrowings        : Association to many Borrowings on borrowings.member = $self;
  reviews           : Association to many Reviews on reviews.member = $self;
}

// ───────────────── REVIEWS ─────────────────
entity Reviews {
  key ID            : UUID;

  book              : Association to Books;
  member            : Association to Members;

  rating            : Integer;
  comment           : String(500);
  reviewDate        : Date;
}

// ───────────────── BORROWINGS ─────────────────
entity Borrowings {
  key ID            : UUID;

  member            : Association to Members;
  book              : Association to Books;

  borrowDate        : Date;
  dueDate           : Date;
  returnDate        : Date;
  status            : BorrowStatus;
  fineAmount        : Amount;
}