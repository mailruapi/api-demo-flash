package {
public function keys ($hash:Object):Array {
    var $res:Array = [];
    for (var $key:String in $hash) $res.push($key);
    return $res;
}
}