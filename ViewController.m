
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UISegmentedControl *categoriasControl;
@property (nonatomic, strong) UILabel *datoLabel;
@property (nonatomic, strong) UIButton *datoButton;

@property (nonatomic, strong) NSArray *datosCiencia;
@property (nonatomic, strong) NSArray *datosNaturaleza;
@property (nonatomic, strong) NSArray *datosHistoria;

@property (nonatomic, strong) NSMutableDictionary *indicesAnteriores;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"¿Sabías qué?";
    self.view.backgroundColor =
        [UIColor colorWithRed:0.96 green:0.94 blue:1.0 alpha:1.0];

    // Datos de la categoría Ciencia
    self.datosCiencia = @[
        @"La luz del Sol tarda aproximadamente 8 minutos en llegar a la Tierra.",
        @"Un día en Venus dura más que un año en Venus.",
        @"El cuerpo humano adulto tiene normalmente 206 huesos.",
        @"El agua puede existir en estado sólido, líquido y gaseoso."
    ];

    // Datos de la categoría Naturaleza
    self.datosNaturaleza = @[
        @"Los pulpos tienen tres corazones.",
        @"Los tiburones existen desde antes que los árboles.",
        @"El bambú puede crecer muy rápidamente.",
        @"Algunas tortugas pueden vivir más de 100 años."
    ];

    // Datos de la categoría Historia
    self.datosHistoria = @[
        @"La Universidad de Oxford es más antigua que el Imperio azteca.",
        @"Cleopatra vivió más cerca de la llegada del ser humano a la Luna que de la construcción de la Gran Pirámide.",
        @"La imprenta de Gutenberg se desarrolló en Europa en el siglo XV.",
        @"La escritura apareció hace miles de años en distintas civilizaciones antiguas."
    ];

    self.indicesAnteriores = [NSMutableDictionary dictionary];

    // Título
    UILabel *titulo = [[UILabel alloc] init];
    titulo.text = @"¡Descubre algo nuevo!";
    titulo.font = [UIFont boldSystemFontOfSize:26];
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.numberOfLines = 0;
    titulo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titulo];

    // Selector de categorías
    self.categoriasControl =
        [[UISegmentedControl alloc]
            initWithItems:@[@"Ciencia", @"Naturaleza", @"Historia"]];

    self.categoriasControl.selectedSegmentIndex = 0;
    self.categoriasControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.categoriasControl];

    // Área del dato curioso
    self.datoLabel = [[UILabel alloc] init];
    self.datoLabel.text =
        @"Selecciona una categoría y presiona el botón para descubrir un dato curioso.";
    self.datoLabel.font = [UIFont systemFontOfSize:19];
    self.datoLabel.textAlignment = NSTextAlignmentCenter;
    self.datoLabel.numberOfLines = 0;
    self.datoLabel.backgroundColor = [UIColor whiteColor];
    self.datoLabel.layer.cornerRadius = 16;
    self.datoLabel.layer.masksToBounds = YES;
    self.datoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.datoLabel];

    // Botón
    self.datoButton =
        [UIButton buttonWithType:UIButtonTypeSystem];

    [self.datoButton setTitle:@"¡Saber más!"
                     forState:UIControlStateNormal];

    self.datoButton.titleLabel.font =
        [UIFont boldSystemFontOfSize:18];

    [self.datoButton setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];

    self.datoButton.backgroundColor =
        [UIColor colorWithRed:0.39 green:0.25 blue:0.72 alpha:1.0];

    self.datoButton.layer.cornerRadius = 12;
    self.datoButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.datoButton addTarget:self
                        action:@selector(mostrarDato)
              forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.datoButton];

    // Posicionamiento de los elementos
    [NSLayoutConstraint activateConstraints:@[
        [titulo.topAnchor constraintEqualToAnchor:
            self.view.safeAreaLayoutGuide.topAnchor constant:50],

        [titulo.leadingAnchor constraintEqualToAnchor:
            self.view.leadingAnchor constant:20],

        [titulo.trailingAnchor constraintEqualToAnchor:
            self.view.trailingAnchor constant:-20],

        [self.categoriasControl.topAnchor constraintEqualToAnchor:
            titulo.bottomAnchor constant:35],

        [self.categoriasControl.leadingAnchor constraintEqualToAnchor:
            self.view.leadingAnchor constant:20],

        [self.categoriasControl.trailingAnchor constraintEqualToAnchor:
            self.view.trailingAnchor constant:-20],

        [self.datoLabel.topAnchor constraintEqualToAnchor:
            self.categoriasControl.bottomAnchor constant:35],

        [self.datoLabel.leadingAnchor constraintEqualToAnchor:
            self.view.leadingAnchor constant:20],

        [self.datoLabel.trailingAnchor constraintEqualToAnchor:
            self.view.trailingAnchor constant:-20],

        [self.datoLabel.heightAnchor
            constraintGreaterThanOrEqualToConstant:180],

        [self.datoButton.topAnchor constraintEqualToAnchor:
            self.datoLabel.bottomAnchor constant:30],

        [self.datoButton.centerXAnchor constraintEqualToAnchor:
            self.view.centerXAnchor],

        [self.datoButton.widthAnchor constraintEqualToConstant:200],

        [self.datoButton.heightAnchor constraintEqualToConstant:52]
    ]];
}

// Método que muestra un dato curioso
- (void)mostrarDato {

    NSInteger categoria =
        self.categoriasControl.selectedSegmentIndex;

    NSArray *datos;

    switch (categoria) {
        case 0:
            datos = self.datosCiencia;
            break;

        case 1:
            datos = self.datosNaturaleza;
            break;

        case 2:
            datos = self.datosHistoria;
            break;

        default:
            return;
    }

    NSString *clave =
        [NSString stringWithFormat:@"%ld", (long)categoria];

    NSNumber *ultimoIndice = self.indicesAnteriores[clave];

    NSInteger indiceAnterior =
        ultimoIndice ? ultimoIndice.integerValue : -1;

    NSInteger indice;

    // Evita repetir inmediatamente el mismo dato
    do {
        indice = arc4random_uniform((uint32_t)datos.count);
    } while (datos.count > 1 && indice == indiceAnterior);

    self.indicesAnteriores[clave] = @(indice);

    self.datoLabel.text = datos[indice];
}

@end
