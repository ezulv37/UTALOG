// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "./mypage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function () {
  const allDropdownToggles = document.querySelectorAll('.dropdown_toggle');

  allDropdownToggles.forEach(toggle => {
    toggle.addEventListener('click', function (e) {
      e.stopPropagation();

      const currentMenu = toggle.closest('.dropdown').querySelector('.dropdown_menu');

      // 他の開いているメニューを全て閉じる
      document.querySelectorAll('.dropdown_menu.show').forEach(menu => {
        if (menu !== currentMenu) {
          menu.classList.remove('show');
        }
      });

      // 自分のメニューを開閉
      currentMenu.classList.toggle('show');
    });
  });

  // 外部クリックで全メニュー閉じる
  document.addEventListener('click', function () {
    document.querySelectorAll('.dropdown_menu.show').forEach(menu => {
      menu.classList.remove('show');
    });
  });
});
