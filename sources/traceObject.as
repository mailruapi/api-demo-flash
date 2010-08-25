package {
	
import flash.utils.getQualifiedClassName;

public function traceObject ( obj : *, shift : String = '-> ' ) : String {
    var str : String = '';
    var substr : String
    
    var QCN : String;
    for ( var ind : String in obj ) {
    	str += '\n' + shift + ind + ' : ';
    	QCN = getQualifiedClassName ( obj[ind] );
    	if ( QCN == 'String' || obj[ind] is Boolean || obj[ind] is Number ) { str += '' + obj[ind]; }
    	else if ( keys ( obj[ind] ).length == 0 ) {
    		if ( QCN == 'Object' ) { str += '[Empty Object]'; }
    		else if ( QCN == 'Array' ) { str += '[Empty Array]'; }
    	} 
    	else {
    		if ( QCN == 'Object' ) { str += '[Object]'; }
    		else if ( QCN == 'Array' ) { str += '[Array]'; }
    		substr = traceObject ( obj[ind], '-' + shift ); 
    		str += substr;
    	}
    }
    
    if ( str == '' ) { str = obj + ''; }
    
    return str;
}}