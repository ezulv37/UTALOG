document.addEventListener("turbolinks:load", () => {
  // タブの見出し（tab-btn）を取得
  const tabBtns = document.querySelectorAll(".tab-btn");

  tabBtns.forEach((tabBtn) => {
    tabBtn.addEventListener("click", () => {
      // すべてのタブを非アクティブにする
      tabBtns.forEach((t) => {
        t.classList.remove("active");
      });
      // すべてのコンテンツを非表示にする
      const tabContents = document.querySelectorAll(".tab-content");
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
});
