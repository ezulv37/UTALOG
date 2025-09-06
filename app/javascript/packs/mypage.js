document.addEventListener("turbolinks:load", () => {
  const tabBtns = document.querySelectorAll(".tab_btn");
  const tabContents = document.querySelectorAll(".tab_content");

  // URLパラメータから?tab=xxx を取得
  const urlParams = new URLSearchParams(window.location.search);
  const defaultTab = urlParams.get("tab") || "practice";

  // タブ切り替えの関数
  const switchTab = (tabName) => {
    tabBtns.forEach((btn) => {
      btn.classList.toggle("active", btn.dataset.tab === tabName);
    });
    tabContents.forEach((content) => {
      content.classList.toggle("active", content.dataset.tab === tabName);
    });
  };

  // 初回読み込み時のタブ
  switchTab(defaultTab);

  // タブクリック時
  tabBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
      const selected = btn.dataset.tab;
      switchTab(selected);
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

  // 閉じるボタンをクリックするとモーダルが閉じる
  closeSpan.onclick = function() {
    modal.style.opacity = "0";
    modal.style.visibility = "hidden";
  };
});
