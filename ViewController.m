
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *facts;
@property (nonatomic, assign) NSInteger lastFactIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"¿Sabías qué?";
    self.lastFactIndex = -1;

    self.facts = @{
        @"Ciencia": @[
            @"Los pulpos tienen tres corazones.",
            @"La luz del Sol tarda unos 8 minutos en llegar a la Tierra.",
            @"El ADN contiene información genética."
        ],
        @"Historia": @[
            @"La escritura cuneiforme surgió en la antigua Mesopotamia.",
            @"La imprenta de tipos móviles de Gutenberg se desarrolló en Europa en el siglo XV.",
            @"La Universidad de Oxford ya existía antes de 1200."
        ],
        @"Naturaleza": @[
            @"Los tiburones existen desde antes que los árboles.",
            @"El bambú puede crecer muy rápidamente.",
            @"Los girasoles jóvenes siguen la dirección del Sol."
        ]
    };

    self.factLabel.text =
        @"Selecciona una categoría y toca Mostrar dato.";
}

- (IBAction)showFact:(id)sender {

    NSInteger selectedIndex =
        self.categoryControl.selectedSegmentIndex;

    if (selectedIndex == UISegmentedControlNoSegment) {
        self.factLabel.text =
            @"Primero selecciona una categoría.";
        return;
    }

    NSArray *categories = @[
        @"Ciencia",
        @"Historia",
        @"Naturaleza"
    ];

    NSString *category = categories[selectedIndex];
    NSArray *categoryFacts = self.facts[category];

    NSInteger randomIndex;

    do {
        randomIndex = arc4random_uniform(
            (uint32_t)categoryFacts.count
        );
    } while (randomIndex == self.lastFactIndex);

    self.lastFactIndex = randomIndex;

    NSString *fact = categoryFacts[randomIndex];

    self.factLabel.text = [
        NSString stringWithFormat:
        @"¿Sabías qué?\n\n%@\n\n%@",
        category,
        fact
    ];
}

@end
