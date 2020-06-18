require 'pry'
require 'json'
require 'rest-client'


#Welcome the user
def welcome
  puts "Welcome!"
end
#Ask the user for a search term
def get_search_term
  puts "Enter a search term below:"
  gets.chomp
end
#Find books using the Google Books API
#Parse the JSON response that comes back
def search_for_book(search_term)
  url = "https://www.googleapis.com/books/v1/volumes?q=#{search_term}"
  resp = RestClient.get(url)
  hash = JSON.parse(resp)
  hash["items"]
end
#Display info for a single book
def display_book_info(book)
  puts "Title: " + get_book_title(book)
  puts "Snippet: " + get_book_snippet(book)
  puts ""
end

def get_book_title(book)
  if book["volumeInfo"]["title"] == []
    "Title not available"
  else
    "#{book["volumeInfo"]["title"]}"
  end
end

def get_book_snippet(book)
  if book["searchInfo"]["textSnippet"] == []
    "Snippet not available"
  else
    "#{book["searchInfo"]["textSnippet"]}"
  end
end
#Loop through each book in the results
#For each book display title and snippet
def display_all_book_info(books)
  books.each {|book| display_book_info(book)}
end


def run
  welcome
  search_term = get_search_term
  books = search_for_book(search_term)
  display_all_book_info(books)
end

run

# binding.pry
# puts "Bye"