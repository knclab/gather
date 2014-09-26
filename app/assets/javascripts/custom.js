$(function(){

  var $container = $('#contents');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector: '.box'
      // columnWidth: 200, //一列の幅サイズを指定
      // isAnimated: true, //スムースアニメーション設定
      // isFitWidth: true, //親要素の幅サイズがピッタリ
      // isRTL: false,     //整理される要素が左右逆になる（読み言語などに）
      // gutterWidth: 0,   //整理される要素間の溝の幅を指定
      // containerStyle: { position: 'relative' }, //親要素にスタイルを追加できる
      // isResizable: true //ウィンドウサイズが変更された時に並び替え
    });
  });

  $container.infinitescroll({
    navSelector  : 'ul.pagination',    // ナビゲーション
    nextSelector : 'ul.pagination a:last',  // 次ページへのリンク
    itemSelector : '.box',     // 次ページ内で探す要素
    loading: {
        finishedMsg: '',
        img: '/assets/ajax-loader.gif'//ローディング画像
      }
    },
    // コールバック
    function( newElements ) {
      $('#paginate').remove();
      var $newElems = $( newElements );
      // ボックスを配列させる前に画像をロードしとく
      $newElems.imagesLoaded(function(){
        $container.masonry( 'appended', $newElems, true );
      });
    }
  );


//  $container.infinitescroll({
//    navSelector  : '#page-nav',    // ナビゲーション
//    nextSelector : '#page-nav a',  // 次ページへのリンク
//    itemSelector : '.box',     // 次ページ内で探す要素
//    loading: {
//        finishedMsg: 'もう無いよ',
//        img: '/assets/ajax-loader.gif'//ローディング画像
//      }
//    },
//    // コールバック
//    function( newElements ) {
//      var $newElems = $( newElements );
//      // ボックスを配列させる前に画像をロードしとく
//      $newElems.imagesLoaded(function(){
//        $container.masonry( 'appended', $newElems, true );
//      });
//    }
//  );


});
