json.extract! book, :id, :title, :author, :status, :notes, :category_id, :created_at, :updated_at
json.url book_url(book, format: :json)
