import 'package:flutter/material.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/pages/jobseeker/jobDetailSeeker_page.dart';
import 'package:login_app/variables.dart';

class JobCardComponent extends StatefulWidget {
  final Joblisting job;
  final bool enableBookmark;
  const JobCardComponent(
      {super.key, required this.job, this.enableBookmark = true});

  @override
  State<JobCardComponent> createState() => _JobCardComponentState();
}

class _JobCardComponentState extends State<JobCardComponent> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the destination page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDetailSeeker(job: widget.job)),
            );
          },
          child: Container(
              width: widget.enableBookmark
                  ? screenWidth - 20 - 65
                  : screenWidth - 20,
              height: 120,
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: accentColor,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            widget.job.corpLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.job.corpName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.job.jobTitle,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          widget.job.jobSalary,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
        if (widget.enableBookmark)
          Row(
            children: [
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  // to-do handle tap
                  setState(() {
                    isBookmarked = !isBookmarked; // Toggle bookmark state
                  });
                },
                child: Container(
                  width: 60,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: accentColor,
                  ),
                  child: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      color: isBookmarked ? Colors.black : Colors.white,
                      size: 30,
                      semanticLabel: isBookmarked
                          ? 'click to remove saved job'
                          : 'click to save job'),
                ),
              )
            ],
          )
      ],
    );
  }
}
