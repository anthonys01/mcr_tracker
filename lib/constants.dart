final turnNames = [
  "east1",
  "east2",
  "east3",
  "east4",
  "south1",
  "south2",
  "south3",
  "south3",
  "west1",
  "west2",
  "west3",
  "west4",
  "north1",
  "north2",
  "north3",
  "north4",
  "finished"
];

final turnNamesShort = [
  "東-1",
  "東-2",
  "東-3",
  "東-4",
  "南-1",
  "南-2",
  "南-3",
  "南-4",
  "西-1",
  "西-2",
  "西-3",
  "西-4",
  "北-1",
  "北-2",
  "北-3",
  "北-4",
];

final windChars = {
  "East": "東",
  "West": "西",
  "North": "北",
  "South": "南",
  "": ""
};

final fourPlayersTurns = [
  ["East", "North", "West", "South",
    "South", "East", "North", "West",
    "North", "West", "South", "East",
    "West", "South", "East", "North"],
  ["South", "East", "North", "West",
    "East", "North", "West", "South",
    "West", "South", "East", "North",
    "North", "West", "South", "East"],
  ["West", "South", "East", "North",
    "North", "West", "South", "East",
    "East", "North", "West", "South",
    "South", "East", "North", "West"],
  ["North", "West", "South", "East",
    "West", "South", "East", "North",
    "South", "East", "North", "West",
    "East", "North", "West", "South"],
];

final fivePlayersTurns = [
  ["East", "", "North", "West",
    "South", "East", "", "North",
    "West", "South","East", "",
    "North", "West", "South", "East"],
  ["South", "East", "", "North",
    "West", "South", "East", "",
    "North", "West","South", "East",
    "", "North", "West", "South"],
  ["West", "South", "East", "",
    "North", "West", "South", "East",
    "", "North","West", "South",
    "East", "", "North", "West"],
  ["North", "West", "South", "East",
    "", "North", "West", "South",
    "East", "","North", "West",
    "South", "East", "", "North"],
  ["", "North", "West", "South",
    "East", "", "North", "West",
    "South", "East","", "North",
    "West", "South", "East", ""]
];
