/**
 * by Michelle ye
 * */

function fn() {
    var env = karate.env;

    karate.log('karate.env system property was ll:', env);

    if (!env) {
        env = 'local';
    }

    switch (env) {
        case 'local':
            localBaseUrl = 'http://localhost'
            localport = 8080
            break;
    }


    var config =
        {
            env: env,
            localURL: localBaseUrl + ':' + localport + "/Jupiter"
        };

//  karate.configure('connectTimeout', 30000);
//  karate.configure('readTimeout', 60000);
    karate.log('karate.env is:', env);

    return config;

}