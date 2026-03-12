Species APP
API Doc: `https://aes.shenlu.me/api`

To do:

- UI
  - Bottom Tab bar with 3 items: home, explore, favorites
  - Home page
    - Show Total species count
    - Show Total counties count
    - Show Total view count
    - Show Random specy with image and detail
    - When user click on image open browser to wiki page.
      example: `"https://en.wikipedia.org/wiki/$use _scientific_name$"`
      Convert space of scientific_name, ex: Beatragus hunteri to Beatragus_hunteri
    - `scientific_name` can be found in `https://aes.shenlu.me/api/v1/random`
    - Show heart icon on top right image, when user click save that specy object to local storage
    - if that specy aleady save, show message to user that: Specy already add to favorite.
  - Explore Page
    - Show List of all species, api: `https://aes.shenlu.me/api/search`
    - Handle search specicies by name, api `https://aes.shenlu.me/api/search?q=$your_search_value`
    - Show heart icon on top right image, when user click save that specy object to local storage
    - if that specy aleady save, show message to user that: Specy already add to favorite.
    - When click on each item, redirect to wiki page on browser, follow home page example.
    - Sort result: https://aes.shenlu.me/api/search?q=p&sortDirection=$desc|$asc
    - desc = is a param to api for Descending
    - asc = is a param to api for Ascending
  - Favorites Page
    - Show List all of favorite species
    - Swipe to remove from favorite list
    - When click on each item, redirect to wiki page on browser, follow home page example.
