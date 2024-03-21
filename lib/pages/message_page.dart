import 'package:chat_app/app.dart';
import 'package:chat_app/helpers.dart';
import 'package:chat_app/models/message_data.dart';
import 'package:chat_app/models/story_data.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:chat_app/widgets/display_error_message.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and(
      [
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [
          StreamChatCore.of(context).currentUser!.id,
        ])
      ],
    ),
  );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedValueListenableBuilder<int, Channel>(
      valueListenable: channelListController,
      builder: (context, value, child) {
        return value.when(
          (channels, nextPageKey, error) {
            if (channels.isEmpty) {
              return const Center(
                child: Text(
                  'So empty.\nGo and message someone.',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return LazyLoadScrollView(
              onEndOfPage: () async {
                if (nextPageKey != null) {
                  channelListController.loadMore(nextPageKey);
                }
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: _Stories(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _MessageTitle(channel: channels[index]);
                      },
                      childCount: channels.length,
                    ),
                  )
                ],
              ),
            );
          },
          loading: () => Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e) => DisplayErrorMessage(
            error: e,
          ),
        );
      },
    );
  }
}

class _MessageTitle extends StatelessWidget {
  final Channel channel;

  const _MessageTitle({Key? key, required this.channel}) : super(key: key);

  Widget _buildLastMessage(){
    return BetterStreamBuilder<Message>(
      stream: channel.state!.lastMessageStream,
      initialData: channel.state!.lastMessage,
      builder: (context, lastMessage){
        return Text(
          lastMessage.text ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: AppColors.textFaded),
        );
      },
    );
  }

  Widget _buildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {

          stringDate = Jiffy.parse(lastMessageAt.toLocal().toString()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy.parse(lastMessageAt.toLocal().toString()).EEEE;
        } else {
          stringDate = Jiffy.parse(lastMessageAt.toLocal().toString()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey,
          width: 0.2,
        ))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Avatar.medium(url: Helpers.getChannelImage(channel, context.currentUser!)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Helpers.getChannelName(channel, context.currentUser!),
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                      child: _buildLastMessage(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _buildLastMessageAt(),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textLigth,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, left: 16),
              child: Text(
                'Stories',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textFaded),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final faker = Faker();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60,
                      child: _StoryCard(
                        storyData: StoryData(
                          name: faker.person.name(),
                          url: Helpers.randomPictureUrl(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final StoryData storyData;
  const _StoryCard({Key? key, required this.storyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppColors.textFaded),
            ),
          ),
        )
      ],
    );
  }
}
