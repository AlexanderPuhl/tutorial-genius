<?php wp_footer(); ?>

<footer>
  <?php
  wp_nav_menu(
    array(
      'theme_location' => 'footer_nav',
      'container' => 'nav'
    )
  )
  ?>
</footer>
</body>

</html>