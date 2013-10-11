
# this sort of json response is required by jQuery-File-Upload 

json.array!([@photo]) do |json, photo|
  json.name photo.photo.original_filename
  json.size photo.photo.size
  json.url photo.photo.url( :large )
  json.thumbnail_url photo.photo.url( :thumb )
  json.delete_url photo_path(photo)
  json.delete_type "DELETE"
  json.name photo.name
end