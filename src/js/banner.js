var megamanSprite = '';

var changeAnimation = function(sprite, animationName, frameRate){
  if(sprite && animationName && frameRate){
    sprite.stop();
    sprite.setIndex(0);
    sprite.setFrameRate(frameRate);
    sprite.setAnimation(animationName);
    sprite.start();
  }
};

var frameSize = 140;
var animationSet = {
  intro: [
    {
      x: 0,
      y: 0,
      width: frameSize,
      height: frameSize
    },
    {
      x: 0,
      y: frameSize,
      width: frameSize,
      height: frameSize
    },
    {
      x: 0,
      y: frameSize * 2,
      width: frameSize,
      height: frameSize
    },
    {
      x: 0,
      y: frameSize * 3,
      width: frameSize,
      height: frameSize
    },
    {
      x: 0,
      y: frameSize * 4,
      width: frameSize,
      height: frameSize
    },
    {
      x: 0,
      y: frameSize * 5,
      width: frameSize,
      height: frameSize
    },
    {
      x: 0,
      y: frameSize * 6,
      width: frameSize,
      height: frameSize
    }
  ],
  idle: [
    {
      x: frameSize,
      y: 0,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize,
      y: frameSize,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize,
      y: frameSize * 2,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize,
      y: frameSize * 3,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize,
      y: frameSize * 4,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize,
      y: frameSize * 5,
      width: frameSize,
      height: frameSize
    }
  ],
  run: [
    {
      x: frameSize * 2,
      y: 0,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 2,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 3,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 4,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 5,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 6,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 7,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 8,
      width: frameSize,
      height: frameSize
    },
    {
      x: frameSize * 2,
      y: frameSize * 9,
      width: frameSize,
      height: frameSize
    }
  ],
  grab: [
    {
      x: frameSize * 7,
      y: frameSize * 3,
      width: frameSize,
      height: frameSize
    }
  ]
};

var megamanAnimationStart = function() {

  var canvasWidth = $(window).outerWidth();
  var canvasHeight = $('#banner').outerHeight();

  var stage = new Kinetic.Stage({
    container: 'megaman',
    width: canvasWidth,
    height: canvasHeight
  });
  var layer = new Kinetic.Layer();

  var megamanImg = new Image();
  megamanImg.onload = function() {
    megamanSprite = new Kinetic.Sprite({
      x: 0,
      y: 0,
      image: megamanImg,
      animations: animationSet,
      animation: 'intro',
      index: 0,
      draggable: true
    });

    layer.add(megamanSprite); // add the shape to the layer
    stage.add(layer); // add the layer to the stage

    var bodySelector = $('body');
    megamanSprite
      .on('mouseover', function(){
        bodySelector.css('cursor', 'url(./img/cursor_grab_open.png) 23 23, auto');
      })
      .on('mouseout', function(){
        bodySelector.css('cursor', 'default');
      })
      .on('dragstart',function() {
        bodySelector.css('cursor', 'url(./img/cursor_grab_closed.png) 23 23, auto');
        changeAnimation(megamanSprite, 'grab', 1);
      })
      .on('dragend', function() {
        bodySelector.css('cursor', 'default');
        anim.start();
        changeAnimation(megamanSprite, 'idle', 8);
      });

    var anim = new Kinetic.Animation(function( frame ) {
      var velocity = 350;
      var dist = velocity * (frame.timeDiff / 1000);
      megamanSprite.move(0, dist);

      if( megamanSprite.getPosition().y >= canvasHeight - 80 - frameSize ) {
        anim.stop();
        changeAnimation(megamanSprite, 'intro', 10);
        megamanSprite.afterFrame(6, function() { // after megaman appears, start running
          changeAnimation(megamanSprite, 'run', 15);
        });
      }
    }, layer);

    anim.start();
  };
  megamanImg.src = './img/megaman-sprites@2x.png';
};

$(window).load(function() {

  megamanAnimationStart();

  var panAnimated = $('.pan-animation');

  var onHover = function() {
    panAnimated.addClass('animation-paused');
    changeAnimation(megamanSprite, 'idle', 8);
  };

  var outHover = function() {
    panAnimated.toggleClass('animation-paused');
    changeAnimation(megamanSprite, 'run', 15);
  };

  var socialIcon = $('.social-icons a');
  socialIcon.hoverIntent(onHover, outHover);
});