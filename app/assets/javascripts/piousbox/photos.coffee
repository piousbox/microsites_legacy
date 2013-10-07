
$(document).ready ->

  if $('.set-profile-photo').length > 0

    $('.set-profile-photo').hover(
      ->
        $('.set-profile-photo-tooltip').show()
      ->
        $('.set-profile-photo-tooltip').hide()
    )
