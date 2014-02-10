$(function() {

  var viewport = $(window);
  var vpWidth = viewport.outerWidth();

  var megaman = $('#megaman');
  var megamanHeight = megaman.outerHeight();
  //  var metool = $('#metool');
  var metoolCopter = $('#metool-copter');
  //  var metoolHeight = metool.outerHeight();
  //  var blocks = $('#banner, #websites, #apps');
  var bannerLayers = $('.banner-layer');
  //  var bannerHeight = viewport.outerHeight() - 150;
  var bannerHeight = $('#banner').outerHeight();
  var streetHeight = 70;
  var socialIcon = $('.social-icons a');

  //  blocks.outerHeight(bannerHeight);
  //  metool.css('top', bannerHeight - metoolHeight - streetHeight);

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

    megaman.animate({top: bannerHeight - megamanHeight - streetHeight}, 700, 'easeInCirc', function() {
        megaman.addClass('intro');
        //        metool.addClass('intro');
      }).on('animationend webkitAnimationEnd MSAnimationEnd oAnimationEnd', function() {
        megaman.removeClass().addClass('run');
        //        metool.removeClass().addClass('run');
        bannerLayers.addClass('pan');
      }).draggable({
        //        revertDuration: 1000,
        start: function() {
          megaman.removeClass().addClass('grabbed');
          bannerLayers.addClass('animation-paused');
        },
        drag: function( e, ui ) {
          ui.originalPosition.left = ui.position.left;
        },
        //        revert: function() {
        //          megaman.removeClass().addClass('falling');
        //          return true;
        //        },
        stop: function( e, ui ) {
          megaman.removeClass().addClass('falling').animate({top: ui.originalPosition.top}, 700, 'easeInCirc', function() {
              megaman.removeClass().addClass('run');
            });
          bannerLayers.removeClass('animation-paused');
        }
      });

    metoolCopter.on('mouseover', function() {
      var originalPos = $(this).position();
      var offset = 150;
      var nextPos = {};
      var pos = [
        {
          top: offset,
          left: offset
        },
        {
          top: bannerHeight - offset,
          left: Math.floor(vpWidth / 2)
        },
        {
          top: offset,
          left: vpWidth - offset
        }
      ];

      if( _.isEqual(originalPos, pos[0]) ) {
        nextPos = pos[1];
      } else if( _.isEqual(originalPos, pos[1]) ) {
        nextPos = pos[2];
      } else if( _.isEqual(originalPos, pos[2]) ) {
        nextPos = pos[0];
      }

      $(this).animate({ left: nextPos.left, top: nextPos.top}, 1500, 'easeInBack');
    });
  });
});