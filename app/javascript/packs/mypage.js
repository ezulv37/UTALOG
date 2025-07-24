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
});
