Simple Lightning component that'll automatically pin certain listviews for users who see it (and don't already have a listview pinned). It works by adjusting the window.locationStorage of a client (which is how Salesforce maintains which  listviews a user has pinned). I seem to recall having to set the API version of this a couple of versions back otherwise Lightning Locker understandably stops you interacting with it - sorry I can't give more detail but it's been a couple of months since I wrote this!

1. Import the files above
2. Create default listview settings by adjusting the Default Listview metadata type.
3. Add the DefaultListViewSetter to a Lightning home page (or a page that the user is guaranteed to see).

Written for the Cabinet Office & shared open source in line with item 12 of the GDS service standard. 
