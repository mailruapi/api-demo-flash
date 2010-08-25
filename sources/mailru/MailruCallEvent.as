package mailru {
	
import flash.events.Event;

public class MailruCallEvent extends Event {
	
	static public var PERMISSIONS_CHANGED   : String = 'common.permissionChanged';
	static public var FRIENDS_INVITATION    : String = 'app.friendsInvitation';
	static public var REVIEW                : String = 'app.review';
	static public var INCOMING_PAYMENT      : String = 'app.incomingPayment';
	static public var PAYMENT_DIALOG_STATUS : String = 'app.paymentDialogStatus';
	static public var ALBUM_CREATED         : String = 'common.createAlbum';
	static public var GUESTBOOK_PUBLISH     : String = 'common.guestbookPublish';
	static public var STREAM_PUBLISH        : String = 'common.streamPublish';
	
	public var data : Object;
	
	public function MailruCallEvent ( type : String, data : Object ) {
		super ( type );
		this.data = data;
	}
	
	override public function clone (  ) : Event {
		return new MailruCallEvent ( type, data ) as Event;
	}
	
}}