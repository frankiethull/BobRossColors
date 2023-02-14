#' Scale Fills, A ggplot2 helper function
#'
#' @param painting a vector of painting names
#' @param type     divergent, qualitative, or both
#'
#' @return a set of hex values to scale colors on a ggplot2 object
#' @export
#'
#' @examples scale_fill_bob_ross(painting = "peaceful_valley", type = "qualitative")
#'

scale_fill_bob_ross <- function(painting = c("peaceful_valley", "a_walk_in_the_woods"),
                                type = c("divergent", "qualitative")) {

  scale_colors <-
    all_palettes |>
    dplyr::filter(painting_title %in% painting) |>
    tidyr::pivot_longer(-c(img_src, painting_title, n),
                        names_to = "types", values_to = "hex") |>
    dplyr::filter(types %in% type) |>
    dplyr::arrange(painting_title, types, n) # maintaining order, could randomize ..


  return(ggplot2::scale_fill_manual(values = I(scale_colors$hex)))

}
