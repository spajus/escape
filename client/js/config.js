(function(Escape) {
  Escape.Config = {
    server: '/',
    map: '#map',
    scrollbackChars: 5000,
    gridWidth:  7,
    gridHeight: 7
  };

  Escape.Config.IsPlayerSpot = function(row, col) {
    return row == Math.ceil(Escape.Config.gridHeight / 2) - 1 &&
           col == Math.ceil(Escape.Config.gridWidth / 2) - 1;
  };

  Escape.Config.ServerAction = function(action) {
    return Escape.Config.server + action;
  };


}(window.Escape = window.Escape || {}));
