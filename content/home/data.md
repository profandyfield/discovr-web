+++
widget = "hero"  # See https://sourcethemes.com/academic/docs/page-builder/
headless = true  # This file represents a page section.
active = true  # Activate this widget? true/false
weight = 30  # Order that this section will appear in.

title = "Data files"

# Hero image (optional). Enter filename of an image in the `static/img/` folder.
hero_media = "discovr_data.png"

[design.background]
  # Apply a background color, gradient, or image.
  #   Uncomment (by removing `#`) an option to apply it.
  #   Choose a light or dark text color by setting `text_color_light`.
  #   Any HTML color name or Hex value is valid.

  # Background color.
  color = "#2C5577"
  
  # Background gradient.
  #gradient_start = "#4bb4e3"
  #gradient_end = "#2b94c3"
  
  # Background image.
   image = "pirate_box.png"  # Name of image in `static/img/`.
   image_darken = 0.3  # Darken the image? Range 0-1 where 0 is transparent and 1 is opaque.
   image_size = "contain"  #  Options are `cover` (default), `contain`, or `actual` size.
   image_position = "center"  # Options include `left`, `center` (default), or `right`.
   image_parallax = false  # Use a fun parallax-like fixed background effect? true/false
  
  # Text color (true=light or false=dark).
  text_color_light = true

# Call to action links (optional).
#   Display link(s) by specifying a URL and label below. Icon is optional for `[cta]`.
#   Remove a link/note by deleting a cta/note block.
[cta]
  url = "/csv/discovr_csv.zip"
  label = "Get CSV files"
  icon_pack = "fas"
  icon = "download"
  
[cta_alt]
  url = "/discovr/"
  label = "Use the R package instead"

# Note. An optional note to show underneath the links.
[cta_note]
  label = ''
+++

Click here to download the data files in CSV format.

