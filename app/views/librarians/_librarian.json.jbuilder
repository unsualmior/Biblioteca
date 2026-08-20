json.extract! librarian, :id, :name, :email, :password_digest, :first_access, :created_at, :updated_at
json.url librarian_url(librarian, format: :json)
