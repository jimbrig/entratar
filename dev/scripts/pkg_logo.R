
#  ------------------------------------------------------------------------
#
# Title : Package Logo
#    By : Jimmy Briggs
#  Date : 2026-07-11
#
#  ------------------------------------------------------------------------

man_figures_path <- file.path(this.path::this.proj(), "man/figures")
if (!dir.exists(man_figures_path)) dir.create(man_figures_path)

# create composite logo -------------------------------------------------------------------------------------------

# note: see man/figures/entrataR.png

# local({
#   entrata_img <- magick::image_read_svg("man/figures/entrata.svg", width = 1200)
#   r_img <- magick::image_read("man/figures/R.png") |> magick::image_scale("220")
#
#   entrata_info <- magick::image_info(entrata_img)
#   r_info <- magick::image_info(r_img)
#
#   target_cx <- 820
#   target_cy <- 620
#
#   x_off <- target_cx - r_info$width  / 2
#   y_off <- target_cy - r_info$height / 2
#
#   combined_img <- magick::image_composite(
#     entrata_img,
#     r_img,
#     offset = magick::geometry_point(x_off, y_off)
#   )
#
#   magick::image_write(combined_img, "man/figures/entratar.png")
# })

# setup hex logo --------------------------------------------------------------------------------------------------

hex_img <- "man/figures/entrataR.png"
sysfonts::font_add_google("Ubuntu", "ubuntu")
showtext::showtext_auto()

# svg ---------------------------------------------------------------------

hexSticker::sticker(
  filename = "man/figures/hex.logo.svg",
  # package name
  package = "", # pkgload::pkg_name(), - intentionally leaving blank
  p_x = 1,
  p_y = 1.4,
  p_color = "white",
  p_family = "ubuntu",
  p_fontface = "plain",
  p_size = 6,
  # image
  subplot = hex_img,
  s_x = 1,
  s_y = 1,
  s_width = 0.8,
  s_height = 1.2,
  asp = 1,
  dpi = 800,
  # hexagon
  h_size = 1.2,
  h_fill = "#191919",  # monochromeR::rgb_to_hex(c(25, 25, 25))
  h_color = "#2268BC", # monochromeR::rgb_to_hex(c(34, 104, 188))
  # url
  url = "github.com/jimbrig/entratar",
  u_x = 1,
  u_y = 0.08,
  u_color = "cyan",
  u_family = "ubuntu",
  u_size = 1.2,
  u_angle = 30
)

# png ---------------------------------------------------------------------

hexSticker::sticker(
  filename = "man/figures/hex.logo.png",
  # package name
  package = "", # pkgload::pkg_name(), - intentionally leaving blank
  p_x = 1,
  p_y = 1.4,
  p_color = "white",
  p_family = "ubuntu",
  p_fontface = "plain",
  p_size = 6,
  # image
  subplot = hex_img,
  s_x = 1,
  s_y = 1,
  s_width = 0.8,
  s_height = 1.2,
  asp = 1,
  dpi = 800,
  # hexagon
  h_size = 1.2,
  h_fill = "#191919",  # monochromeR::rgb_to_hex(c(25, 25, 25))
  h_color = "#2268BC", # monochromeR::rgb_to_hex(c(34, 104, 188))
  # url
  url = "github.com/jimbrig/entratar",
  u_x = 1,
  u_y = 0.08,
  u_color = "cyan",
  u_family = "ubuntu",
  u_size = 1.2,
  u_angle = 30
)

# Warning: Using ragg device as default. Ignoring `type` and `antialias` arguments
# messes up the URL display for whatever reason.

# using my custom man/figures/entratar.hex.png image i made via hexmak application
# instead...

# set package logo ------------------------------------------------------------------------------------------------

usethis::use_logo("man/figures/entratar.hex.png")
