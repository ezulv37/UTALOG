document.addEventListener("turbolinks:load", () => {
  // タブの見出し（tab_btn）を取得
  const tabBtns = document.querySelectorAll(".tab_btn");

  tabBtns.forEach((tabBtn) => {
    tabBtn.addEventListener("click", () => {
      // すべてのタブを非アクティブにする
      tabBtns.forEach((t) => {
        t.classList.remove("active");
      });
      // すべてのコンテンツを非表示にする
      const tabContents = document.querySelectorAll(".tab_content");
      tabContents.forEach((tabContent) => {
        tabContent.classList.remove("active");
      });

      // クリックされたタブをアクティブにする
      tabBtn.classList.add("active");

      // 対応するコンテンツを表示
      const tabIndex = Array.from(tabBtns).indexOf(tabBtn);
      tabContents[tabIndex].classList.add("active");
    });
  });

  // モーダルウィンドウ全体
  const modal = document.getElementById('modal');

  // モーダル内で拡大表示される画像
  const modalImg = document.getElementById('modalImage');

  // .popupクラスを持つ画像
  const imgs = document.querySelectorAll('.popup');

  // モーダルを閉じるためのボタン
  const closeSpan = document.getElementById('close');

  // 画像クリックでモーダルを表示するイベント
  for( let img of imgs) {
    img.onclick = function(){
      // モーダルを表示する
      modal.style.opacity = "1";
      modal.style.visibility = "visible";

      // モーダルで表示する画像に、クリックした画像のパスを設定する
      modalImg.src = this.src;
    }
  }

  // 画像以外の部分をクリックしたらモーダルを閉じる
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.opacity = "0";
      modal.style.visibility = "hidden";
    }
  }
});
