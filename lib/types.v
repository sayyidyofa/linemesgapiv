module main

struct Config {
	channel_access_token: string
	channel_secret: string
}

struct ClientConfig {
	Config
	fetch_config ?FetchConfig
}

struct Profile {
	display_name string
	user_id string
	picture_url string
	status_message string
	language string
}

struct WebhookRequestBody {
	destination string
	events []WebhookEvent
}

type WebhookEvent = MessageEvent
  | UnsendEvent
  | FollowEvent
  | UnfollowEvent
  | JoinEvent
  | LeaveEvent
  | MemberJoinEvent
  | MemberLeaveEvent
  | PostbackEvent
  | VideoPlayCompleteEvent
  | BeaconEvent
  | AccountLinkEvent
  | DeviceLinkEvent
  | DeviceUnlinkEvent
  | LINEThingsScenarioExecutionEvent

enum ChannelState {
   /**
   * Channel state.
   *
   * `active`: The channel is active. You can send a reply message or push message from the bot server that received this webhook event.
   *
   * `standby`: The channel is waiting. The bot server that received this webhook event shouldn't send any messages.
   */
	active
	standby
}

struct EventBase {
	mode ChannelState
	timestamp i64
	source EventSource
}

type EventSource = User | Group | Room

enum EventSourceType {
	user
	group
	room
}

struct User {
	source_type EventSourceType [json: "type"]
	user_id string
}

struct Group {
	source_type EventSourceType [json: "type"]
	group_id string
	/**
    * ID of the source user.
    *
    * Only included in [message events](https://developers.line.biz/en/reference/messaging-api/#message-event).
    * Not included if the user has not agreed to the
    * [Official Accounts Terms of Use](https://developers.line.biz/en/docs/messaging-api/user-consent/).
    */
    user_id string
}

struct Room {
	source_type EventSourceType [json: "type"]
	room_id string
	/**
    * ID of the source user.
    *
    * Only included in [message events](https://developers.line.biz/en/reference/messaging-api/#message-event).
    * Not included if the user has not agreed to the
    * [Official Accounts Terms of Use](https://developers.line.biz/en/docs/messaging-api/user-consent/).
    */
    user_id string
}

struct ReplyableEvent {
	EventBase
	reply_token string
}

enum EventType {
	message
	unsend
	follow
	unfollow
	join
	leave
	memberJoined
	memberLeft
	postback
	videoPlayComplete
	beacon
	accountLink
	things
}

struct MessageEvent {
	event_type EventType [json: "type"]
	message EventMessage
	ReplyableEvent
}

struct UnsentMessage {
	message_id string
}

struct UnsendEvent {
	event_type EventType [json: "type"]
	unsend UnsentMessage
	EventBase
}

struct FollowEvent {
	event_type EventType [json: "type"]
	ReplyableEvent
}

struct UnfollowEvent {
	event_type EventType [json: "type"]

}
