# Titan OS Exercise

## How to install the application

```
rbenv install ruby 4.0.6 # in case you don't have this version
bundle install
rails db:migrate
rails db:seed

# Start the server
rails s 
```

## How to use the application

There's one available endpoint:

`GET http://localhost:3000/lists/[list_id]`

Optionally filter by content_type

`http://localhost:3000/lists/[list_id]?content_type=episode`

There are 4 available content_types:
- movie
- tv_show
- season
- episode

Optionally use pagination

```
http://localhost:3000/lists/[list_id]?page=[page_number]
http://localhost:3000/lists/[list_id]?per_page=[per_page_number]
http://localhost:3000/lists/[list_id]?page=[page_number]&per_page=[per_page_number]
```

You can combine params too

`http://localhost:3000/lists/[list_id]?content_type=episode&page=[page_number]`

## How to test the application

```
rspec .
```

## Dependencies

```
ruby 4.0.6
sqlite3
```

## Assumptions

- I have assumed that the list ordering decides on the order of items within that list as I thought that was the logical approach.
Still, seasons and episodes do have their own order.
- I haven't added any extra fields to the models as I thought that wasn't relevant to the exercise and I was lacking on time. I can imagine **at least** the following:
  ```ruby
    add_column :movies, :runtime, :integer
    add_column :movies, :rating, :decimal, precision: 2, scale: 1
    add_column :movies, :synopsis, :text
  ```

## Further improvements

- Return a 204 (No Content) when requesting a page that doesn't exist
- Improve the metadada in the result set:
  - e.g. Add a reference to the parent in the case of episodes/seasons to understand the relation between the item and its parent
    ```json
    {
      "title": "Aftermath",
      "original_title": "Aftermath",
      "year": 2011,
      "type": "episode",
      "number": 1,
      "season": {
        "title": "The Reckoning",
        "original_title": "The Reckoning",
        "number": 2,
        "total_episodes": 10
      },
      "tv_show": {
        "title": "The Bridge",
        "original_title": "Bron/Broen",
        "year": 2011,
        "total_seasons": 5
      }
    }
    ```

## Use of AI

Considering this is an interview-type coding exercise, I haven't used AI except for:
  - The tests
  - The seed file
  - The usual questions to ChatGPT (free plan) you'd instead ask Google pre-2023 :-)