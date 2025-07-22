// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

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

        // タブ切り替え機能
        function switchTab(tabName) {
          // すべてのタブコンテンツを非表示
          const tabContents = document.querySelectorAll('.tab-content');
          tabContents.forEach(content => {
              content.classList.remove('active');
          });

          // すべてのタブボタンを非アクティブ
          const tabButtons = document.querySelectorAll('.tab-btn');
          tabButtons.forEach(button => {
              button.classList.remove('active');
          });

          // 指定されたタブコンテンツを表示
          document.getElementById(tabName).classList.add('active');

          // 対応するタブボタンをアクティブ
          event.target.classList.add('active');
      }

      // ページ読み込み時の初期化
      document.addEventListener('DOMContentLoaded', function() {
          // 音声再生ボタンのクリックイベント
          const audioButtons = document.querySelectorAll('.audio-player button');
          audioButtons.forEach(button => {
              button.addEventListener('click', function() {
                  // 実際のアプリケーションでは、ここで音声ファイルを再生する処理を実装
                  const isPlaying = this.textContent === '停止';
                  this.textContent = isPlaying ? '再生' : '停止';

                  if (!isPlaying) {
                      // 再生状態の表示
                      this.style.background = 'linear-gradient(45deg, #ff00ff, #ff6b6b)';
                      setTimeout(() => {
                          this.textContent = '再生';
                          this.style.background = '';
                      }, 3000); // 3秒後に停止
                  }
              });
          });

          // 結果画像のクリックイベント
          const resultImages = document.querySelectorAll('.result-image');
          resultImages.forEach(image => {
              image.addEventListener('click', function() {
                  // 実際のアプリケーションでは、ここで画像を拡大表示する処理を実装
                  this.style.transform = 'scale(1.1)';
                  setTimeout(() => {
                      this.style.transform = '';
                  }, 200);
              });
          });
      });
