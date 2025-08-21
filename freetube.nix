{ config, pkgs, ... }:

{
  programs.freetube = {
  	enable = true;
	settings = {
	checkForUpdates = false;
	defaultQuality = "1440";
	baseTheme = "catppuccinMocha";
	quickBookmarkTargetPlaylistId = "favorites";
	checkForBlogPosts = false;
	generalAutoLoadMorePaginatedItemsEnabled = true;
	openDeepLinksInNewWindow = true;
	barColor = false;
	hideLabelsSideBar = true;
	hideHeaderLogo = false;
	expandSideBar = true;
	enableSubtitlesByDefaultvalue = true;
	displayVideoPlayButton=true;
	defaultViewingMode = "theatre";
	defaultPlayback = 2;
	enableScreenshot = true;
	screenshotAskPath = false;
	hideTrendingVideos = true;
	hideSubscriptionsShorts = true;
	hideChannelShorts=true;
	downloadBehavior = "download";
	useSponsorBlock = true;
	};
  };

}
