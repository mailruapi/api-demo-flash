package{
public function delegate ( func : Function, ...additArgs ) : Function {
	return function ( ...args ) : void {
		func.apply ( null, args.concat ( additArgs ) );
	}
}
}