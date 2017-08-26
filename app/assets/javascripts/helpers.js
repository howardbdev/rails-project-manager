clearQuickView = (e) => {
  if (e) {
    e.preventDefault();
  }
  $(`.index-display.quick-view-rt`).html("");
}
