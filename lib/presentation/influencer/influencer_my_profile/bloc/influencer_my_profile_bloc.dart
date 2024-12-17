import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

part 'influencer_my_profile_event.dart';
part 'influencer_my_profile_state.dart';

class InfluencerMyProfileBloc
    extends Bloc<InfluencerMyProfileEvent, InfluencerMyProfileState> {
  InfluencerMyProfileBloc() : super(InfluencerMyProfileInitial()) {
    on<InfluencerMyProfileEvent>((event, emit) {});
    on<OnInstagramIconTap>((event, emit) {
      openInstagram();
    });
    on<OnXIconTap>((event, emit) {
      openTwitter();
    });
    on<OnFBIconTap>((event, emit) {
      openFacebook();
    });
    on<OnSnapIconTap>((event, emit) {
      openSnapchat();
    });
  }
  // Function to open Instagram
  Future<void> openInstagram() async {
    const instagramUrl = 'instagram://';
    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      // If Instagram is not installed, open in the browser
      const fallbackUrl = 'https://www.instagram.com';
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      }
    }
  }

  // Function to open Snapchat
  Future<void> openSnapchat() async {
    const snapchatUrl = 'snapchat://';
    if (await canLaunch(snapchatUrl)) {
      await launch(snapchatUrl);
    } else {
      // If Snapchat is not installed, open in the browser
      const fallbackUrl = 'https://www.snapchat.com';
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      }
    }
  }

  // Function to open Facebook
  Future<void> openFacebook() async {
    const facebookUrl = 'fb://';
    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      // If Facebook is not installed, open in the browser
      const fallbackUrl = 'https://www.facebook.com';
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      }
    }
  }

  // Function to open Twitter
  Future<void> openTwitter() async {
    const twitterUrl = 'twitter://';
    if (await canLaunch(twitterUrl)) {
      await launch(twitterUrl);
    } else {
      // If Twitter is not installed, open in the browser
      const fallbackUrl = 'https://www.twitter.com';
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      }
    }
  }
}
