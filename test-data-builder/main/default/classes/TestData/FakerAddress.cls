//@IsTest
public with sharing class FakerAddress {
    private static List<String> place = new List<String> {
        'Flat {0}', 'Studio {0}', '{0}' 
    };

    private static List<String> streetPrefix = new List<String> {
        'Ham', 'Happy', 'Mis', 'Upper', 'Lower', 'Canter', 'Sally', 'Beaver', 'Byron'
    };

    private static List<String> streetSuffix = new List<String> {
        'Alley', 'Avenue', 'Branch', 'Bridge', 'Brook', 'Brooks', 'Burg', 'Burgs', 'Bypass', 'Camp', 'Canyon', 'Cape', 'Causeway', 'Center', 'Centers', 'Circle', 'Circles', 'Cliff', 'Cliffs', 'Club', 'Common', 'Corner', 'Corners', 'Course', 'Court', 'Courts', 'Cove', 'Coves', 'Creek', 'Crescent', 'Crest', 'Crossing', 'Crossroad', 'Curve', 'Dale', 'Dam', 'Divide', 'Drive', 'Drive', 'Drives', 'Estate', 'Estates', 'Expressway', 'Extension', 'Extensions', 'Fall', 'Falls', 'Ferry', 'Field', 'Fields', 'Flat', 'Flats', 'Ford', 'Fords', 'Forest', 'Forge', 'Forges', 'Fork', 'Forks', 'Fort', 'Garden', 'Gardens', 'Gateway', 'Glen', 'Glens', 'Green', 'Greens', 'Grove', 'Groves', 'Harbour', 'Harbours', 'Haven', 'Heights', 'Highway', 'Hill', 'Hills', 'Hollow', 'Inlet', 'Island', 'Islands', 'Isle', 'Junction', 'Junctions', 'Key', 'Keys', 'Knoll', 'Knolls', 'Lake', 'Lakes', 'Land', 'Landing', 'Lane', 'Light', 'Lights', 'Loaf', 'Lock', 'Locks', 'Locks', 'Lodge', 'Lodge', 'Loop', 'Manor', 'Manors', 'Meadow', 'Meadows', 'Mews', 'Mill', 'Mills', 'Motorway', 'Mount', 'Mountain', 'Mountains', 'Neck', 'Orchard', 'Oval', 'Overpass', 'Park', 'Parks', 'Parkway', 'Parkways', 'Pass', 'Passage', 'Path', 'Pike', 'Pine', 'Pines', 'Place', 'Plain', 'Plains', 'Plaza', 'Point', 'Points', 'Port', 'Ports', 'Radial', 'Ramp', 'Ranch', 'Rapid', 'Rapids', 'Rest', 'Ridge', 'Ridges', 'River', 'Road', 'Road', 'Roads', 'Roads', 'Route', 'Row', 'Rue', 'Run', 'Shoal', 'Shoals', 'Shore', 'Shores', 'Spring', 'Springs', 'Springs', 'Spur', 'Spurs', 'Square', 'Square', 'Squares', 'Squares', 'Station', 'Station', 'Stream', 'Stream', 'Street', 'Streets', 'Summit', 'Terrace', 'Throughway', 'Trace', 'Track', 'Trafficway', 'Trail', 'Tunnel', 'Turnpike', 'Underpass', 'Union', 'Valley', 'Valleys', 'Views', 'Village', 'Villages', 'Ville', 'Walk', 'Wall', 'Way', 'Wells'
    };

    private static List<String> cityPrefix = new List<String> {
        'North', 'East', 'West', 'South', 'New', 'Lake', 'Port'
    };

    private static List<String> citySuffix = new List<String> {
        'town', 'ton', 'land', 'ville', 'berg', 'burgh', 'borough', 'bury', 'view', 'port', 'mouth', 'stad', 'furt', 'chester', 'mouth', 'fort', 'haven', 'side', 'shire'
    };

    private static List<String> postCode = new List<String> {
        'DD8 1LR','HU7 4FE','SG6 1PR','DN40 3PT','PO21 3JR','BN13 3DN','B23 5RS','W5 5PA','ML12 6XR','WR2 4HQ','TR16 6EU','TF4 2NU',
        'HU8 8SH','TS24 7QA','SE11 5SD','WV99 1TL','TR16 5TN','NP16 6QT','BT60 3QU','TA24 6LB','TS23 1AD','W1G 9PN','WA1 4PJ','CM22 6DR',
        'BL7 8BW','FK2 8DB','LL65 4LN','LL21 0RG','SP6 1NH','EN1 4AE','WR5 1DG','NW6 9FA','NG18 3AZ','N14 5HW','CO9 3JZ','CW12 1BP',
        'BT41 2RX','CT6 9AR','ST10 4JQ','HD9 7ED','SW6 1LG','KY10 3RL','LA8 9RA','RH20 2LH','WF9 2JY','N11 1RH','BT78 2JU','ME6 5PD',
        'CB22 7PT','BS4 2BH','NR10 3QE','ST3 5SH','WA5 1QF','B17 0LW','WA7 1EN','SP3 6WD','LL48 6SE','MK3 7SA','CV34 4DF','CW1 5PG'
    };

    private static List<String> county = new List<String> {
        'Aberdeenshire', 'Anglesey', 'Angus', 'Argyll', 'Ayrshire', 'Banffshire', 'Bedfordshire', 'Berwickshire', 'Breconshire', 'Buckinghamshire', 'Bute', 'Caernarvonshire', 'Caithness', 'Cambridgeshire', 'Cardiganshire', 'Carmarthenshire', 'Cheshire', 'Clackmannanshire', 'Cornwall', 'Isles of Scilly', 'Cumbria', 'Denbighshire', 'Derbyshire', 'Devon', 'Dorset', 'Dumbartonshire', 'Dumfriesshire', 'Durham', 'East Lothian', 'East Sussex', 'Essex', 'Fife', 'Flintshire', 'Glamorgan', 'Gloucestershire', 'Greater London', 'Greater Manchester', 'Hampshire', 'Hertfordshire', 'Inverness', 'Kent', 'Kincardineshire', 'Kinross-shire', 'Kirkcudbrightshire', 'Lanarkshire', 'Lancashire', 'Leicestershire', 'Lincolnshire', 'London', 'Merionethshire', 'Merseyside', 'Midlothian', 'Monmouthshire', 'Montgomeryshire', 'Moray', 'Nairnshire', 'Norfolk', 'North Yorkshire', 'Northamptonshire', 'Northumberland', 'Nottinghamshire', 'Orkney', 'Oxfordshire', 'Peebleshire', 'Pembrokeshire', 'Perthshire', 'Radnorshire', 'Renfrewshire', 'Ross & Cromarty', 'Roxburghshire', 'Selkirkshire', 'Shetland', 'Shropshire', 'Somerset', 'South Yorkshire', 'Staffordshire', 'Stirlingshire', 'Suffolk', 'Surrey', 'Sutherland', 'Tyne and Wear', 'Warwickshire', 'West Lothian', 'West Midlands', 'West Sussex', 'West Yorkshire', 'Wigtownshire', 'Wiltshire', 'Worcestershire'
    };

    private static List<String> country = new List<String> { 'United Kingdon' };

    public static String addressLine1() {
        String place = place[rnd(place.size() -1)];
        return string.format(place, new String[] {
            String.valueOf(rnd(350))
        });
    }

    public static String addressLine2() {
        return string.format('{0} {1}', new String[] {
            streetPrefix[rnd(streetPrefix.size() -1)],
            streetSuffix[rnd(streetSuffix.size() -1)]
        });
    }

    public static String city() {
        return string.format('{0} {1}', new String[] {
            cityPrefix[rnd(cityPrefix.size() -1)],
            citySuffix[rnd(citySuffix.size() -1)]
        });
    }

    public static String county() {
        return string.format('{0}', new String[] {
            county[rnd(county.size() -1)]
        });
    }

    public static String postCode() {
        return string.format('{0}', new String[] {
            postCode[rnd(postCode.size() -1)]
        });
    }

    private static Integer rnd(Integer maximum) {
        return Integer.valueof((Math.random() * maximum));
    }
}
