app = angular.module("SecretAlbum", ["ngResource"])

app.factory "PhotoEntry", ($resource) ->
    PhotoEntry = $resource("/albums/:album_id/photos/:id", {album_id: "@album_id", id: "@id"}, {update: {method: "PUT"}})
    
app.factory "Album", ($resource) ->
  Album = $resource("/albums/:album_id/show_json", {album_id: "@album_id"}, {get: {method: "GET"}})

app.controller "PhotoController", ($scope, PhotoEntry, Album) ->
  $scope.getAlbumID = (album_id) ->
    $scope.photos = PhotoEntry.query({album_id: album_id})
    $scope.album = Album.get(album_id: album_id)
