//@IsTest
public inherited sharing class FakerPerson {
    private static List<String> firstNameMale = new List<String> {
        'Aaron', 'Adam', 'Adrian', 'Aiden', 'Alan', 'Andrew', 'Andy', 'Anthony',
        'Barry', 'Chris', 'Colin', 'Damien', 'Dan', 'Dave', 'Dean',
        'Edward', 'Elliott', 'Ethan','George', 'Graham', 'Harrison', 'Ian', 'Jack', 'James', 
        'Karl', 'Keith', 'Lee', 'Leo', 'Lewis', 'Mark', 'Martin', 'Mohammed', 'Muhammad',
        'Nathan', 'Neil', 'Nick', 'Oliver', 'Paul', 'Pete', 'Rob', 'Ross', 'Scott', 'Steve',
        'Tim', 'Wayne', 'William','Zach'            
    };

    private static List<String> firstNameFemail = new List<String> {
        'Abigail', 'Adele', 'Alexa', 'Amanda', 'Amy', 'Anna', 'Beth', 'Becky',
        'Caitlin', 'Charlotte', 'Daisy', 'Donna', 'Eileen', 'Elizabeth', 'Emma', 'Faye', 'Florence', 'Georgia', 'Hannah', 'Holly',
        'Imogen', 'Jane', 'Justine','Kirsty', 'Laura', 'Lisa', 'Lucy',
        'Melissa', 'Naomi', 'Natalie', 'Natasha', 'Nicole', 'Phoebe', 'Rebecca', 'Ruby','Sarah', 'Scarlett', 'Selina', 'Shannon', 'Suzanne', 'Summer',
        'Tanya', 'Tina', 'Vanessa', 'Vicky', 'Zoe'
    };

    private static List<String> lastName = new List<String> {
        'Adams', 'Bailey','Chapman', 'Clark', 'Cook', 'Davis', 'Ellis', 'Evans', 'Fox', 'Griffiths',
        'Hall', 'Harris', 'Jackson', 'Jones', 'Khan', 'Knight', 'Lewis', 'Palmer', 'Patel', 'Reynolds', 'Richards', 
        'Saunders', 'Smith', 'Stevens', 'Turner', 'Walker', 'Wright', 'Young'
    };
    
    public static String firstName() {
        List<String> allNames = new List<String>();
        allNames.addAll(firstNameMale);
        allNames.addAll(firstNameFemail);
    
        return string.format('{0}', new String[] {
            allNames[rnd(allNames.size() -1)]
        });
    }

    public static String lastName() {
        return string.format('{0}', new String[] {
            lastName[rnd(lastName.size() -1)]
        });
    }

    private static Integer rnd(Integer maximum) {
        return Integer.valueof((Math.random() * maximum));
    }
}

/*
System.Debug(FakerEmail.address());
System.Debug(FakerEmail.address());
System.Debug(FakerEmail.address());
System.Debug(FakerAddress.addressLine1());
System.Debug(FakerAddress.addressLine2());
System.Debug(FakerAddress.city());
System.Debug(FakerAddress.county());
System.Debug(FakerAddress.postCode());
System.Debug(FakerPerson.firstName());
System.Debug(FakerPerson.lastName());
*/