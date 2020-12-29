enum PlotType {
  Line,
  Scatter,
  Bar,
  TimePeriod,
}

class DataItem {
  DateTime timestamp;
  double value;
  String name;
}

class DataSeries {
  String name;
  String description;
  List<DataItem> items;
  PlotType plotType;
  double minValue;
  double maxValue;
}

class DataCard {
  String name;
  List<DataSeries> serii;
  DateTime startDate; // earliest data item
  DateTime endDate; // latest data item
}

DataCard GenerateDummyData() {
  DataCard dc = DataCard()
    ..serii = List<DataSeries>()
    ..name = "Code With Indy Stats";
  final ds1 = DataSeries()
    ..name = "Views"
    ..plotType = PlotType.Line
    ..items = [
      DataItem()
        ..timestamp = DateTime(2020, 05, 29)
        ..value = 98,
      DataItem()
        ..timestamp = DateTime(2020, 06, 4)
        ..value = 101,
      DataItem()
        ..timestamp = DateTime(2020, 06, 13)
        ..value = 1688,
      DataItem()
        ..timestamp = DateTime(2020, 06, 19)
        ..value = 600,
      DataItem()
        ..timestamp = DateTime(2020, 06, 26)
        ..value = 804,
      DataItem()
        ..timestamp = DateTime(2020, 07, 3)
        ..value = 185,
      DataItem()
        ..timestamp = DateTime(2020, 07, 5)
        ..value = 195,
      DataItem()
        ..timestamp = DateTime(2020, 07, 9)
        ..value = 532,
      DataItem()
        ..timestamp = DateTime(2020, 07, 16)
        ..value = 81,
      DataItem()
        ..timestamp = DateTime(2020, 07, 24)
        ..value = 73,
      DataItem()
        ..timestamp = DateTime(2020, 07, 27)
        ..value = 169,
      DataItem()
        ..timestamp = DateTime(2020, 07, 29)
        ..value = 60,
      DataItem()
        ..timestamp = DateTime(2020, 07, 31)
        ..value = 182,
      DataItem()
        ..timestamp = DateTime(2020, 07, 31)
        ..value = 484,
      DataItem()
        ..timestamp = DateTime(2020, 08, 7)
        ..value = 1088,
      DataItem()
        ..timestamp = DateTime(2020, 08, 14)
        ..value = 501,
      DataItem()
        ..timestamp = DateTime(2020, 08, 21)
        ..value = 341,
      DataItem()
        ..timestamp = DateTime(2020, 08, 29)
        ..value = 232,
      DataItem()
        ..timestamp = DateTime(2020, 09, 1)
        ..value = 378,
      DataItem()
        ..timestamp = DateTime(2020, 09, 5)
        ..value = 249,
      DataItem()
        ..timestamp = DateTime(2020, 09, 9)
        ..value = 728,
      DataItem()
        ..timestamp = DateTime(2020, 09, 16)
        ..value = 337,
      DataItem()
        ..timestamp = DateTime(2020, 09, 23)
        ..value = 275,
      DataItem()
        ..timestamp = DateTime(2020, 10, 7)
        ..value = 234,
      DataItem()
        ..timestamp = DateTime(2020, 10, 14)
        ..value = 371,
      DataItem()
        ..timestamp = DateTime(2020, 10, 22)
        ..value = 256,
      DataItem()
        ..timestamp = DateTime(2020, 10, 31)
        ..value = 202,
      DataItem()
        ..timestamp = DateTime(2020, 11, 21)
        ..value = 218,
      DataItem()
        ..timestamp = DateTime(2020, 11, 28)
        ..value = 190,
      DataItem()
        ..timestamp = DateTime(2020, 12, 5)
        ..value = 192,
      DataItem()
        ..timestamp = DateTime(2020, 12, 13)
        ..value = 253,
      DataItem()
        ..timestamp = DateTime(2020, 12, 20)
        ..value = 318,
    ];
  // set series min max values
  ds1.minValue = double.maxFinite;
  ds1.maxValue = -double.maxFinite;
  ds1.items.forEach((d) {
    ds1.minValue = d.value < ds1.minValue ? d.value : ds1.minValue;
    ds1.maxValue = d.value > ds1.maxValue ? d.value : ds1.maxValue;
  });
  dc.serii.add(ds1);

  // TODO: Typically, this should be computed
  dc.startDate = DateTime(2020, 05, 29);
  dc.endDate = DateTime(2020, 12, 20);
  return dc;
}

final worldEvents = [
  {
    "name": "Hong Kong Protests - March 2019 onwards",
    "description":
        "The ongoing 2019\u201320 Hong Kong protests were triggered by the Hong Kong government's introduction of the Fugitive Offenders amendment bill. Had it been enacted, the bill would have allowed the extradition of wanted criminal suspects and criminal fugitives to territories with which Hong Kong does not currently have extradition agreements, including Mainland China and Taiwan. This led to concerns that the bill would subject Hong Kong residents and visitors to the jurisdiction and legal system of Mainland China, thereby undermining Hong Kong's autonomy and civil liberties, and infringe on freedom of speech laws. (Wikipedia)\n\nOn September 8, Hong Kong police were largely criticized after a video of them tackling a 12-year-old went viral. The video shows the young girl walking along the street before being approached by police. When she tried to run, the police tackled her to the ground and began allegedly beating her with batons. The police force has defended the officers\u2019 actions, sparking more outrage from protesters. (CNN)",
    "timeFrom": "2019 3 15",
    "timeTo": "2020 9 17",
  },
  {
    "name": "Australian Bushfires",
    "description": "",
    "timeFrom": "2019 9 1",
    "timeTo": "2020 2 23",
  },
  {
    "name": "Chilean protests - Oct 2019 onwards",
    "description":
        "Civil protests have taken place throughout Chile in response to a raise in the Santiago Metro's subway fare, the increased cost of living, privatisation and inequality prevalent in the country.\n\nThe protests began in Chile's capital, Santiago, as a coordinated fare evasion campaign by secondary school students which led to spontaneous takeovers of the city's main train stations and open confrontations with the Carabineros de Chile (the national police force). On 18 October, the situation escalated as a group of people began vandalizing city's infrastructure; seizing, vandalizing, and burning down many stations of the Santiago Metro network and disabling them with extensive infrastructure damage, and for a time causing the cessation of the network in its entirety. 81 stations have sustained major damage, including 17 burned down.\n\nOn the same day, President of Chile Sebastián Piñera announced a state of emergency, authorizing the deployment of Chilean Army forces across the main regions to enforce order and prevent the destruction of public property, and invoked before the courts the Ley de Seguridad del Estado (\"State Security Law\") against dozens of detainees. A curfew was declared on 19 October in the Greater Santiago area. (Wikipedia)",
    "timeFrom": "2019 10 14",
    "timeTo": "2020 6 6",
  },
  {
    "name": "COVID-19 Pandemic",
    "description": "",
    "timeFrom": "2019 11 17",
    "timeTo": "2020 12 31",
  },
  {
    "name": "President Trump Impeachment trial",
    "description":
        "The impeachment trial of Donald Trump, the 45th and incumbent president of the United States, began in the U.S. Senate on January 16, 2020, and concluded with his acquittal on February 5. After an inquiry between September to November 2019, President Trump was impeached by the U.S. House of Representatives on December 18, 2019; the articles of impeachment charge him of abuse of power and obstruction of Congress. (Wikipedia)",
    "timeFrom": "2020 1 16",
    "timeTo": "2020 2 5",
  },
  {
    "name": "Stock Market Crash",
    "description":
        "The stock market crash of 2020 began on Monday, March 9, with history\u2019s largest point plunge for the Dow Jones Industrial Average (DJIA) up to that date.\n\nIt was followed by two more record-setting point drops on March 12 and March 16. The stock market crash included the three worst point drops in U.S. history. (The Balance)",
    "timeFrom": "2020 3 9",
    "timeTo": "2020 3 16",
  },
  {
    "name": "BLM Protests and riots start after George Floyd's death",
    "description":
        "The area around the location at which Floyd died became a makeshift memorial throughout May 26, with many placards paying tribute to him and referencing the Black Lives Matter movement. As the day progressed, more people showed up to demonstrate against Floyd's death. The crowd, estimated to be in the hundreds of people, then marched to the 3rd Precinct of the Minneapolis Police. Participants used posters and slogans with phrases such as \"Justice for George\", \"I Can't Breathe\", and \"Black Lives Matter\".\n\nThe protests were initially peaceful, but later there was vandalism of stores; at the the 3rd Precinct police station windows were broken and fires set. This led to police officers in riot gear using tear gas and flash grenades on the protesters, while some protesters threw rocks and other objects at the police. The police also used rubber bullets and smoke bombs against the protesters. (Wikipedia)",
    "timeFrom": "2020 5 26",
    "timeTo": "2020 10 12",
  },
  {
    "name": "California Wild Fires",
    "description":
        "On August 18, California\u2019s governor declared a state of emergency as a heat wave worsened the fires. While some people are evacuated due to smoke and fires, thousands are without power due to the heat wave. As of August 18, more than two dozen fires are burning across the state. At least 145,000 acres have been burned thus far. By August 23, more than 560 wildfires had burned 1 million acres in California. Due to the pandemic, the state is seeing a shortage in firefighters with no end in sight for the fires. On August 23, President Trump declared a major disaster in California and released federal aid to fight the wildfires. (CNN)\n\nOn September 6, the wildfires in California set a new record, scorching 2,094,955 acres, which is the most acres burned in one year. Experts believe this number will only grow as wildfire season is typically October and November. The wildfires were only exacerbated after a heat wave hit the state. On September 7, a pyrotechnic device used at a gender reveal party sparked another wildfire in the state. The fire has since grown 8,600 acres and is only 7% contained. Elsewhere, the Creek Fire forced a whole town to evacuate as it burned 80,000 acres and is 0% contained. On September 8, just one day after record setting high temperatures, Denver, Colorado saw a blizzard-like snowstorm and freezing temperatures. The snow and freezing temperatures was welcome by the state as it helped contain various wildfires in the area. On September 9, the wildfires from California spread to Oregon and Washington, burning hundreds of homes. High temperatures and strong winds are only making the problem worse, forcing areas in the two states to do mass evacuations. By September 12, the West Coast fires had killed at least 28 people. (CNN)\n\nOn September 28, two new fires in California burned 10,000 acres in just 24 hours. Firefighters continue to fight 25 different fires in the state. The Grass Fire in Napa County grew rapidly, burning 1,500 acres, forcing many homes and hospitals to evacuate. By September 30, the fires continued to rage across the state. First responders are working towards preventing the spread of fires at the moment. (CNN)\n\nAs of October 3, at least two California wildfires were still not managed: The Glass Fire and Zogg Fire. The Glass Fire is only 10% contained and the Zogg Fire is 57% contained. At least 120,000 acres have been destroyed, and at least 40 people have died due to the blazes. The fires are expected to worsen as high temperatures are predicted for the next few days. (CNN)",
    "timeFrom": "2020 8 3",
    "timeTo": "2020 10 26",
  },
  {
    "name": "Wildfires Emerge in Colorado and Utah",
    "description":
        "On October 19, it was reported that at least 4 wildfires have started across Utah and Colorado over the weekend. At least 26 homes have been destroyed due to the CalWood fire in Colorado. Colorado saw two new fires in Boulder County as firefighters continue to fight the Cameron Peak Fire, which is the state\u2019s largest wildfire in history. More than 3,000 acres have been burned by the wildfires that emerged in Utah. Both Utah and Colorado residents are being told to evacuate in the affected areas. On October 23, Colorado highways became clogged after a new fire, East Troublesome Fire, forced more evacuations. The fire has burned 170,000 acres in the Arapaho National Forest and is only 5% contained. (CNN)\n\nColorado wildfire kills couple, forces more evacuations.\n\nResidents remaining in Estes Park, in Colorado's Rocky Mountain National Park, were told to evacuate their homes on Saturday as wind gusts fanned the second largest wildfire in state history and the blaze claimed the lives of an elderly couple.\n\nOfficials issued a mandatory evacuation order for eastern Estes Park as wind gusts pushed the 191,000-acre (77,300-hectare) East Troublesome Fire east, threatening the town of 6,300 people that serves as a base camp for the popular national park. (KSL.com)",
    "timeFrom": "2020 10 19",
    "timeTo": "2020 10 25",
  },
  {
    "name": "US Election protests",
    "description":
        "On November 1, a group of marchers in North Carolina were pepper sprayed by police in an effort to break up the march. The marchers were headed to the polls and held a moment of silence before getting pepper sprayed. A man allegedly began attacking police, sparking the retaliation. \n\nOn November 1, Missouri officials removed a noose from a voting poll. This is one of many controversial actions occurring around voting polls in the world. \n\nOn November 2, a federal judge stated that all USPS services need to expedite all ballots and guarantee one to two day delivery, even after election day. \n\nOn November 3, two lawsuits were filed in federal courts over the pepper spray incident in North Carolina. On the night of November 3, Twitter hid a tweet from President Trump regarding possible cheating in mail-in votes. \n\nThe social media giant also hid tweets from others claiming early victory, as the votes had not been fully counted until November 4. \n\nOn November 6, the election still continued as various swing states had thousands of votes left to count. \n\nAs of the 6th, Biden has a confirmed 253 electoral college votes and President Trump had 214 electoral votes. The past three days have led to various protests and early celebrations in the swing states. Many gathered in Pennsylvania for an early celebration, believing Biden was headed towards victory. (CNN\/BBC)",
    "timeFrom": "2020 11 1",
    "timeTo": "2020 11 6",
  }
];

DataCard GenerateWorldEvents() {
  DataCard dc = DataCard();
  dc.serii = List<DataSeries>();
  dc.name = "World Events";
  dc.startDate = DateTime(2019, 3, 1);
  dc.endDate = DateTime(2020, 12, 31);

  final convertToDate = (String s) {
    final ss = s.split(" ");
    final y = int.parse(ss[0].trim());
    final m = int.parse(ss[1].trim());
    final d = int.parse(ss[2].trim());
    return DateTime(y, m, d);
  };

  worldEvents.forEach((e) {
    DataSeries ds = DataSeries();
    ds.name = e["name"];
    ds.plotType = PlotType.TimePeriod;
    ds.description = e["description"];
    ds.items = List<DataItem>();

    final d1 = DataItem()..timestamp = convertToDate(e["timeFrom"]);
    ds.items.add(d1);
    final d2 = DataItem()..timestamp = convertToDate(e["timeTo"]);
    ds.items.add(d2);

    dc.serii.add(ds);
  });

  return dc;
}
