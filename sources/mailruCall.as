﻿package {	import flash.display.MovieClip;import flash.display.SimpleButton;import flash.display.StageAlign;import flash.display.StageScaleMode;import flash.events.Event;import flash.events.MouseEvent;import flash.external.ExternalInterface;import flash.system.Security;import mailru.MailruCall;import mailru.MailruCallEvent;public class mailruCall extends MovieClip {		private static const CUSTOM_JS_EVENT : String = 'customJSEvent';		private var myID       : String;	private var curAlbumId : String;		private var btnGetMyID          : SimpleButton;	private var btnGetUserInfo      : SimpleButton;	private var btnPermissions      : SimpleButton;	private var btnGetAlbums        : SimpleButton;	private var btnCreateAlbum      : SimpleButton;	private var btnGetPhotos        : SimpleButton;	private var btnGetFiltFriends   : SimpleButton;	private var btnGetAudio         : SimpleButton;	private var btnGetAppUsers      : SimpleButton;	private var btnShowPayment      : SimpleButton;	private var btnPublishGuestbook : SimpleButton;	private var btnPublishStream    : SimpleButton;	private var btnReadHash		    : SimpleButton;			public function mailruCall() {		stage.scaleMode = StageScaleMode.NO_SCALE;		stage.align = StageAlign.TOP_LEFT;		Security.allowDomain ( '*' );		log ( 'App Started!' );		// Теперь можно добавлять слушателей		// COMPLETE диспатчится, когда JS API полностью загрузился и готов к работе		MailruCall.addEventListener ( Event.COMPLETE, mailruReadyHandler );		// Подписываемся на событие, которое может послать нам HTML-часть нашего приложения		MailruCall.addEventListener ( CUSTOM_JS_EVENT, customEventHandler );				// Подписываемся события API		MailruCall.addEventListener ( MailruCallEvent.PERMISSIONS_CHANGED, permissionsChangedHandler );		MailruCall.addEventListener ( MailruCallEvent.ALBUM_CREATED, albumCreatedHandler );		MailruCall.addEventListener ( MailruCallEvent.GUESTBOOK_PUBLISH, guestbookPublishHandler );		MailruCall.addEventListener ( MailruCallEvent.STREAM_PUBLISH, streamPublishHandler );		MailruCall.addEventListener ( MailruCallEvent.STREAM_PUBLISH, streamPublishHandler );		MailruCall.addEventListener ( 'app.readHash', readHashHandler );		MailruCall.addEventListener('app.paymentDialogStatus',showPaymentDialogCallback);		MailruCall.addEventListener('app.friendsInvitation', inviteFriendsHandler);				// Прежде всего необходимо инициализировать MailruCall		MailruCall.init ( loaderInfo.parameters.flashName, loaderInfo.parameters.secretKey );						// Вызываем методы Mail.ru API 		btnGetMyID = (this as MovieClip).btn_getMyID;		btnGetMyID.addEventListener ( MouseEvent.CLICK, btnMyIDHandler );				btnGetUserInfo = (this as MovieClip).btn_getUserInfo;		btnGetUserInfo.addEventListener ( MouseEvent.CLICK, btnGetUserInfoHandler );				btnGetFiltFriends = (this as MovieClip).btn_getFriendsFiltere;		btnGetFiltFriends.addEventListener ( MouseEvent.CLICK, btnGetFiltFriendsHandler );				btnPermissions = (this as MovieClip).btn_requirePermissions;		btnPermissions.addEventListener ( MouseEvent.CLICK, btnNotifPermissionsHandler );				btnGetAlbums = (this as MovieClip).btn_getAlbums;		btnGetAlbums.addEventListener ( MouseEvent.CLICK, btnGetAlbumsHandler );				btnCreateAlbum = (this as MovieClip).btn_createAlbum;		btnCreateAlbum.addEventListener ( MouseEvent.CLICK, btnCreateAlbumHandler );				btnGetPhotos = (this as MovieClip).btn_getPhotos;		btnGetPhotos.addEventListener ( MouseEvent.CLICK, btnGetPhotosHandler );				btnGetAudio = (this as MovieClip).btn_getAudio;		btnGetAudio.addEventListener ( MouseEvent.CLICK, btnGetAudioHandler );				btnGetAppUsers = (this as MovieClip).btn_getAppUsers;		btnGetAppUsers.addEventListener ( MouseEvent.CLICK, btnGetAppUsersHandler );				btnShowPayment = (this as MovieClip).btn_showPaymentDialog;		btnShowPayment.addEventListener ( MouseEvent.CLICK, btnShowPaymentHandler );				btnPublishGuestbook = (this as MovieClip).btn_publishToGuestbook;		btnPublishGuestbook.addEventListener ( MouseEvent.CLICK, btnPublishGuestbookHandler );				btnPublishStream = (this as MovieClip).btn_publishToStream;		btnPublishStream.addEventListener ( MouseEvent.CLICK, btnPublishStreamHandler );				btnReadHash = (this as MovieClip).btn_readHash ;		btnReadHash.addEventListener ( MouseEvent.CLICK, btnReadHashHandler );	}		/** Кастомная функция для отладки **/	public function log ( ...args ) : void {		trace ( args.join ( ', ' ) );		ExternalInterface.call ( 'flashLog', args.join ( ', ' ) );	}		/** Прогрузился API, можно делать вызовы **/	private function mailruReadyHandler ( event : Event ) : void {		log ( 'Mail.ru API ready' );		//MailruCall.exec('mailru.app.users.requireInstallation', null, ["notification", "widget"]);	}		/** Пример получения собственных событий из HTML-части приложения **/	private function customEventHandler ( event : MailruCallEvent ) : void {		log ( 'onCustomEvent(): ' + traceObject ( event.data ) );	}		/** Обработка события common.permissionChanged **/	private function permissionsChangedHandler ( event : MailruCallEvent ) : void {		log ( 'permissionsChangedHandler(): ' + traceObject ( event.data ) );	}		/** Обработка события common.createAlbum **/	private function albumCreatedHandler ( event : MailruCallEvent ) : void {		log ( 'albumCreatedHandler(): ' + traceObject ( event.data ) );	}		/** Обработка события common.guestbookPublish **/	private function guestbookPublishHandler ( event : MailruCallEvent ) : void {		ExternalInterface.call('alert("' + traceObject ( event.data ) + '")')		log ( 'guestbookPublishHandler(): ' + traceObject ( event.data ) );	}		/** Обработка события common.streamPublish **/	private function streamPublishHandler ( event : MailruCallEvent ) : void {		log ( 'streamPublishHandler(): ' + traceObject ( event.data ) );	}		/** Получить свой ID **/	private function btnMyIDHandler ( event : MouseEvent ) : void {		myID = MailruCall.exec ( 'mailru.session.vid' );		log ( 'myID: ' + myID );	}		/** Получить userInfo **/	private function btnGetUserInfoHandler ( event : MouseEvent ) : void {		MailruCall.exec ( 'mailru.common.users.getInfo', getUserInfoCallback );	}		private function getUserInfoCallback ( users : Object ) : void {		log ( 'getUserInfoCallback(): ' + traceObject ( users ) );	}		/** Получить список друзей **/	private function btnGetFiltFriendsHandler ( event : MouseEvent ) : void {		if ( !myID ) { log ( 'Нажмите сначала «Get My ID»' ); return; }		MailruCall.exec ( 'mailru.common.friends.getFiltered', getFriendsFilteredCallback, myID );	}		private function getFriendsFilteredCallback ( friends : Object ) : void {		log ( 'getFriendsFilteredCallback(): ' + traceObject ( friends ) );	}		/** Проверить доступ к функционалу **/	private function btnNotifPermissionsHandler ( event : MouseEvent ) : void {		MailruCall.exec ( 'mailru.common.users.hasAppPermission', null, 'notifications' );	}		/** Получить информацию о альбомах **/	private function btnGetAlbumsHandler ( event : MouseEvent ) : void {		if ( !myID ) { log ( 'Нажмите сначала «Get My ID»' ); return; }		MailruCall.exec ( 'mailru.common.photos.getAlbums', getAlbumsCallback, myID );	}		private function getAlbumsCallback ( albums : Object ) : void {		log ( 'getAlbumsCallback(): ' + traceObject ( albums ) );		if ( albums[0] ) { curAlbumId = albums[0].aid; }		trace ( 'curAlbumId: ' + curAlbumId );	}		/** Получить информацию о альбомах **/	private function btnCreateAlbumHandler ( event : MouseEvent ) : void {		MailruCall.exec ( 'mailru.common.photos.createAlbum', null, { name: 'Album' + Math.ceil(Math.random()*9) } );	}		/** Получить фотки альбома **/	private function btnGetPhotosHandler ( event : MouseEvent ) : void {		if ( !curAlbumId ) { log ( 'Нажмите сначала «Get Albums»' ); return; }		MailruCall.exec ( 'mailru.common.photos.get', getPhotosCallback, curAlbumId, myID );	}		private function getPhotosCallback ( photos : Object ) : void {		log ( 'getPhotosCallback(): ' + traceObject ( photos ) );	}		/** Получить аудиуо-записи **/	private function btnGetAudioHandler ( event : MouseEvent ) : void {		if ( !myID ) { log ( 'Нажмите сначала «Get My ID»' ); return; }		MailruCall.exec ( 'mailru.app.friends.invite', null);	}		private function getAudioCallback ( records : Object ) : void {		log ( 'getAudioCallback(): ' + traceObject ( records ) );	}		/** Получить аудиуо-записи **/	private function btnGetAppUsersHandler ( event : MouseEvent ) : void {		if ( !myID ) { log ( 'Нажмите сначала «Get My ID»' ); return; }		MailruCall.exec ( 'mailru.common.friends.getAppUsers', getAppUsersCallback, 0, myID );	}		private function getAppUsersCallback ( users : Object ) : void {		log ( 'getAppUsersCallback(): ' + traceObject ( users ) );	}		/** Показать диалог оплаты **/	private function btnShowPaymentHandler ( event : MouseEvent ) : void {		MailruCall.exec ( 'mailru.app.payments.showDialog', null, {			service_id: 1,			service_name: 'вилы', 			sms_price: 1,			other_price: 2000		} );	}		private function showPaymentDialogCallback ( event : MailruCallEvent ) : void {		log ( 'showPaymentDialogCallback(): ' + traceObject ( event ) );			}		/** Оставить запись в гостевой книге **/	private function btnPublishGuestbookHandler ( event : MouseEvent ) : void {		if ( !myID ) { log ( 'Нажмите сначала «Get My ID»' ); return; }		var host : String = ExternalInterface.call('function(){return document.location.host;}');		MailruCall.exec ( 'mailru.common.guestbook.publish', null, {			'title': 'Заголовок',			'text': 'Текст',			'img_url': 'http://img-fotki.yandex.ru/get/3508/flashtuchka.19d/0_30dbb_b9d0308b_XL.jpg',			'action_links': [				{'text': 'узнать тоже', 'href': host + '#link1'},				{'text': 'еще ссылка', 'href': host + '?1=2#link2'}			],			uid: myID		} );	}		/** Оставить запись в ленте **/	private function btnPublishStreamHandler ( event : MouseEvent ) : void {		if ( !myID ) { log ( 'Нажмите сначала «Get My ID»' ); return; }		MailruCall.exec ( 'mailru.common.stream.publish', null, {			'title': 'Заголовок',			'text': 'Текст',			'img_url': 'http://bitman.me/mailru/demo/img/stream_pic.jpeg',			'action_links': [				{'text': 'узнать тоже', 'href': 'user=test-user'},				{'text': 'еще ссылка', 'href': 'hash=test-value'}			]		} );	}		private function btnReadHashHandler( event : MouseEvent ) : void {				MailruCall.exec ( 'mailru.app.utils.hash.read', null);	}		private function readHashHandler( hash : Object ) : void {		log ( 'readHash(): ' + traceObject ( hash.data ) );	}		private function inviteFriendsHandler (event : MailruCallEvent ) : void {		log ( 'invite: ' + traceObject ( event.data ) );	}	}}