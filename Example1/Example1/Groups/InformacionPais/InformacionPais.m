//
//  InformacionPais.m
//  Example1
//
//  Created by Juan Tocino on 18/03/2020.
//  Copyright © 2020 Reflejo. All rights reserved.
//

#import "InformacionPais.h"
@import AFNetworking;

@interface InformacionPais ()

@end

@implementation InformacionPais

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getInformacionPais];
    NSLog(@"Llegue: %@", _paisSeleccionado);
}

- (void)getInformacionPais
{
    NSMutableString *url = [[NSMutableString alloc]init];
    [url appendString:@"https://restcountries.eu/rest/v2/name/"];
    [url appendString:_paisSeleccionado];
    [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *URL                      = [NSURL URLWithString:url];
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
            NSDictionary* paisDictionary = (NSDictionary *) responseObject;
            //La respuesta en formato diccionario se envia a la funcion doInformacionPais.
            [self doInformacionPais:paisDictionary];
        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            NSLog(@"Error: %@", error);
        }
    ];
}

//Esta funcion recibe un diccionario por parametro.
- (void) doInformacionPais:(NSDictionary*) paisDictionary
{
    //Iteracion sobre el diccionario de paises.
    for(id pais in paisDictionary)
    {
        NSLog(@"%@", pais);
    }
}

@end
