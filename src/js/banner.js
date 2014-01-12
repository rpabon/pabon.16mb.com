$(function() {

  var viewport = $(window);

  var megaman = $('#megaman');
  var megamanHeight = megaman.outerHeight();
  var metool = $('#metool');
  var metoolHeight = metool.outerHeight();
  var blocks = $('#banner, #websites, #apps');
  var bannerLayers = $('.banner-layer');
  var bannerHeight = viewport.outerHeight() - 150;
  var streetHeight = 70;
  var socialIcon = $('.social-icons a');

  blocks.outerHeight(bannerHeight);
  metool.css('top', bannerHeight - metoolHeight - streetHeight);

  var onSocialIconHover = function() {
    if( !megaman.hasClass('grabbed') ) {
      megaman.removeClass().addClass('idle');
    }
    bannerLayers.addClass('animation-paused');
  };

  var outSocialIconHover = function() {
    if( !megaman.hasClass('grabbed') ) {
      megaman.removeClass().addClass('run');
      bannerLayers.removeClass('animation-paused');
    }
  };

  socialIcon.hoverIntent(onSocialIconHover, outSocialIconHover);

  viewport.load(function() {

    megaman.animate({top: bannerHeight - megamanHeight - streetHeight}, 1000,function() {
        megaman.addClass('intro');
        metool.addClass('intro');
      }).on('animationend webkitAnimationEnd MSAnimationEnd oAnimationEnd', function() {
        megaman.removeClass().addClass('run');
        metool.removeClass().addClass('run');
        bannerLayers.addClass('pan');
      }).draggable({
        revertDuration: 1000,
        start: function() {
          megaman.removeClass().addClass('grabbed');
          bannerLayers.addClass('animation-paused');
        },
        drag: function( e, ui ) {
          ui.originalPosition.left = ui.position.left;
        },
        revert: function() {
          megaman.removeClass().addClass('falling');
          return true;
        },
        stop: function() {
          megaman.removeClass().addClass('run');
          bannerLayers.removeClass('animation-paused');
        }
      });
  });
});