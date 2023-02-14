#' Show Colors & Paintings
#'
#' @param paintings a vector of painting names from all_palettes
#'
#' @return a visualization of palettes and the painting
#' @export
#'
#' @examples show_colors_and_paintings(paintings = c("peaceful_valley"))


show_colors_and_paintings <-
function(paintings = c("peaceful_valley", "a_walk_in_the_woods")) {

  ggpal <-
    all_palettes |>
    dplyr::filter(painting_title %in% paintings) |>
    tidyr::pivot_longer(cols = -c(img_src, painting_title, n),
                        names_to = "type", values_to = "hex_color") |>
    ggplot2::ggplot() +
    ggplot2::geom_tile(ggplot2::aes(x = n, y = type, fill = I(hex_color))) +
    ggplot2::facet_wrap(~painting_title) +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none") +
    ggplot2::labs(title = "Colors & Paintings",
         subtitle = "qualitative and divergent colors")

  img <-
    all_palettes |>
    dplyr::filter(painting_title %in% paintings) |>
    dplyr::pull(img_src) |>
    unique() |>
    magick::image_read()

  # image_ggplot works well for one image, not many
  # gridExtra::grid.arrange(ggpal, magick::image_ggplot(img), nrow = 1)
  # purrr::map(as.list(img), magick::image_ggplot)

  ggpainting <-
    magick::image_montage(img, tile = length(paintings)) |> magick::image_ggplot()

  return(
    gridExtra::grid.arrange(ggpal, ggpainting)
  )
}
