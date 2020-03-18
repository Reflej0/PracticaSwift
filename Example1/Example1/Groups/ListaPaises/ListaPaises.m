//
//  ListaPaises.m
//  Example1
//
//  Created by Juan Tocino on 18/03/2020.
//  Copyright © 2020 Reflejo. All rights reserved.
//

#import "ListaPaises.h"
#import "InformacionPais.h"
@import AFNetworking;

@interface ListaPaises ()
{
    NSArray *_pickerData; //Es como un puntero apunta a una seccion de memoria pero no se le "hizo" el "malloc"
}

@end

@implementation ListaPaises

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getPaises];
}

- (IBAction)verPaisAction:(id)sender
{
    [self performSegueWithIdentifier:@"InformacionPais" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *selectedCountry = _pickerData[[_pickerPaises selectedRowInComponent:0]];
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"InformacionPais"])
    {
        InformacionPais *vc = [segue destinationViewController];
        vc.paisSeleccionado = selectedCountry;
    }
}

- (void)getPaises
{
    NSURL *URL                      = [NSURL URLWithString:@"https://restcountries.eu/rest/v2/all"];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    /* Lo que esta encerrado entre corchetes es un bloque y no puede tener un return adentro, porque ademas es asincrónico (HTTP REQUEST) entonces se realiza como un estilo de callbacks de funciones.
     */
    [manager    GET:URL.absoluteString
        parameters:nil
        progress:nil
        //Si la peticion es correcta.
        success:^(NSURLSessionTask *task, id responseObject)
        {
            //Parseo de respuesta a un diccionario (JSON).
            NSDictionary* paisesDictionary = (NSDictionary *) responseObject;
            //La respuesta en formato diccionario se envia a la funcion loadPickerView.
            [self loadPickerView:paisesDictionary];
        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            NSLog(@"Error: %@", error);
        }
    ];
}

//Esta funcion recibe un diccionario por parametro.
- (void) loadPickerView:(NSDictionary*) paisesDictionary
{
    //Inicializacion un array variable.
    NSMutableArray *paisesArray = [[NSMutableArray alloc] init];
    //Iteracion sobre el diccionario de paises.
    for(id pais in paisesDictionary)
    {
        NSLog(@"%@", pais[@"name"]);
        //Al array solo se agrega la clave del nombre del pais.
        [paisesArray addObject:pais[@"name"]];
    }
    //El array puntero de pickerData ahora apunta a un array variable inicializado.
    _pickerData = paisesArray;
    //Se "recarga"el pickerView.
    [self.pickerPaises reloadAllComponents];
    self.pickerPaises.dataSource = self;
    self.pickerPaises.delegate = self;
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
     return 1;
}
// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerData count];
}
// The data to return for the row and component (column) that's being passed in
 - (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     return _pickerData[row];
}
@end
