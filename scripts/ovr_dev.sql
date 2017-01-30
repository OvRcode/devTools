USE `ovrride`;

UPDATE wp_options SET option_value = replace(option_value, 'ovrride.com', 'ovrride.dev');
/* Change Guids to ovrride.dev */
UPDATE wp_posts SET guid = replace(guid, 'ovrride.com', 'ovrride.dev');
/* Update post content */
UPDATE wp_posts SET post_content = replace(post_content, 'ovrride.com', 'ovrride.dev');
/* Update postmeta */
UPDATE wp_postmeta SET meta_value = replace(meta_value, 'ovrride.com', 'ovrride.dev');

/* Remove Spark Post from active plugins, throws a lot of errors when key is unset */
UPDATE wp_options SET option_value='a:24:{i:0;s:17:"WP-API/plugin.php";i:1;s:19:"akismet/akismet.php";i:2;s:29:"bj-lazy-load/bj-lazy-load.php";i:3;s:45:"ewww-image-optimizer/ewww-image-optimizer.php";i:4;s:45:"no-captcha-recaptcha/no-captcha-recaptcha.php";i:5;s:27:"ovr-widgets/ovr-widgets.php";i:6;s:31:"ovr_functions/ovr_functions.php";i:7;s:33:"post-expirator/post-expirator.php";i:8;s:25:"quickshare/quickshare.php";i:9;s:47:"really-simple-captcha/really-simple-captcha.php";i:10;s:35:"shortcode-maker/shortcode-maker.php";i:11;s:25:"simple-tooltips/index.php";i:12;s:57:"ssl-insecure-content-fixer/ssl-insecure-content-fixer.php";i:13;s:33:"w3-total-cache/w3-total-cache.php";i:14;s:25:"widget-shortcode/init.php";i:15;s:41:"woocommerce-colors/woocommerce-colors.php";i:16;s:67:"woocommerce-customer-note-email/woocommerce-customer-note-email.php";i:17;s:65:"woocommerce-gateway-paypal-pro/woocommerce-gateway-paypal-pro.php";i:18;s:42:"woocommerce-remove-quantity-text/index.php";i:19;s:55:"woocommerce-smart-coupons/woocommerce-smart-coupons.php";i:20;s:39:"woocommerce-trips/woocommerce-trips.php";i:21;s:27:"woocommerce/woocommerce.php";i:22;s:39:"woothemes-updater/woothemes-updater.php";i:23;s:30:"wordpress-wiki-plugin/wiki.php";} ' WHERE option_name='active_plugins' LIMIT 1;
/* Remove API KEY From SP Settings */
UPDATE wp_options SET option_value = ' a:5:{s:10:"from_email";s:16:"info@ovrride.com";s:9:"from_name";s:7:"OvRride";s:16:"enable_sparkpost";b:0;s:14:"sending_method";s:3:"api";s:15:"enable_tracking";b:1;'WHERE option_name = 'sp_settings' LIMIT 1;

/*
Register a development user
User = devops Password = devops
*/
INSERT INTO `ovrride`.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES ('1', 'devops', MD5('devops'), 'Dev Ops', 'developmentaccount@ovrride.com', 'http://www.test.com/', '2011-06-07 00:00:00', '', '0', 'Dev Ops');
INSERT INTO `ovrride`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '1', 'wp_capabilities', 'a:1:{s:13:"administrator";s:1:"1";}');
INSERT INTO `ovrride`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '1', 'wp_user_level', '10');

#UPDATE mysql.user SET Host = '%' WHERE User = 'dev' AND Host = 'localhost';
#DELETE From mysql.user WHERE User = 'dev' AND Host <> '%';
#FLUSH PRIVILEGES;
