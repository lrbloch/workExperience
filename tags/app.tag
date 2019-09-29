<app>
  <!-- HTML -->
  <div style="display: flex; flex-wrap:wrap">
    <div class="card" each={ experience, i in experiences} style="width:350px; margin:20px">
      <img src={experience.imageUrl} class="card-img-top" alt="{experience.company}">
      <div class="card-body">
        <div class="card-title">
          <h4><a href={experience.companyWebsite}>{experience.company}</a></h4>
          <h5>
              <span style="float: left;">{experience.role}</span>
              <span style="float: right;">{experience.startDateFormatted} - {experience.endDateFormatted}</span>
          </h5>
          <br>
        </div>
        <br>
        <p class="card-text" each={ desc, i in experiences[i].description}> {desc} </p>
        <!-- <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p> -->
      </div>
    </div>
  </div>

  <script>
    // JAVASCRIPT
    let tag = this;
    let that = this;
    let database = firebase.firestore();
    let experienceRef = database.collection('experiences');
    this.experiences = [];

    experienceRef.onSnapshot(function (snapshot) {
      var experiences = [];
      snapshot.forEach(function (doc) {
        var exp = doc.data();
        var startDate = timeConverter(exp.start_date);
        var endDate = exp.end_date ? timeConverter(exp.end_date) : "present";
        exp.startDateFormatted = startDate;
        exp.endDateFormatted = endDate;
        experiences.push(exp);
      });
      experiences.sort(compare);
      that.experiences = experiences;
      that.update();
    });

    function compare(expB, expA) {
      let comparison = 0;
      if (expA.start_date > expB.start_date) {
        if(!expA.end_date){
          comparison = 1; //haven't finished working there yet, a is more recent than b
        }
        else if(!expB.end_date){
          comparison = -1; //finished at A, but still working at B
        }
        else if(expA.end_date > expB.end_date){
            comparison = 1; //finished at both, and finished at A more recently
        }
        else {
          comparison = -1; //finished at both, finished at B more recently
        }
      } else if (expA.end_date){
        if(expB.end_date){
          if(expA.end_date > expB.end_date) {
            comparison = 1; //started earlier at A, but ended more recently at A
          }
          else{
            comparison = -1; // started first at A, ended first at A
          }
        }
        else{
          comparison = -1; //still working at B
        }
      }
      else{
        //still working at A, started at A before starting at B
        if(expB.end_date){
          comparison = 1; //not still working at B
        }
        else{
          comparison = -1; //still working at B, B is more recent than A
        }
      }
      return comparison;
    }

    createNewExperiences(e){
      e.preventDefault();
      var experienceData = {
        company : "HOMER",
        companyWebsite: "https://learnwithhomer.com/",
        description: {
          0 : "Collaborate with Product, UX, and UI teams to identify research questions and solutions",
          1 :"Document, analyze, and organize notes from play studies with children ages 2 to 6 and diary studies of parents",
          2: "Work with the product sprint cycle to test and refine new features and content"
        },
        start_date: new Date("09/17/2019").getTime(),
        imageUrl: "https://new.learnwithhomer.com//static/img/meta/HOMER_for_Meta.jpg",
        role: "UX Research Intern"
      };
      var experienceData = {
        company : "Bilingual Assessment of Phonological Sensitivity – Teachers College, Columbia University",
        companyWebsite: "https://www.tc.columbia.edu/dll-lab/research/",
        description: {
          0 : "Conduct direct observation and directed interviews to identify and develop user experience solutions for an application to assess children’s phonological abilities",
          1 :"Perform usability testing and client interviews to understand and adapt to changing expectations and use cases"
        },
        start_date: Date.parse("07/01/2018").getTime(),
        imageUrl: "https://tcmobtool.tc.columbia.edu:3000/images/baps_logo.png",
        role: "Product Development Intern"
      };
      var experienceData = {
        company : "iDesign Lab – Teachers College, Columbia University",
        companyWebsite: "https://tc.columbia.edu/idesign",
        description: {
          0 : "Created user personas and goal statements for redesign of department lab and educational workshops",
          1 : "Researched, designed, and implemented solutions for processes such as inventory management and student support"
        },
        start_date: Date.parse("09/01/2018"),
        end_date: Date.parse("09/01/2019"),
        imageUrl: "https://www.tc.columbia.edu/media/administration/tc-web/branding-assets/tccu_18_portrait_tag_301c_2000.png",
        role: "Graduate Assistant"
      };
      var experienceData = {
        company : "PAST Foundation",
        companyWebsite: "https://pastfoundation.org/",
        description: {
          0 : "Collaborated with K-12 educators and curriculum designers to develop, deliver, and modify STEAM curriculum",
          1 : "Taught elementary programming concepts such as functions, variables, and loops using block-based and text-based programming languages"
        },
        start_date: Date.parse("05/01/2018"),
        end_date: Date.parse("08/01/2019"),
        imageUrl: "https://www.pastfoundation.org/wp-content/themes/PAST/images/logo.jpg",
        role: "Bridge Programs and School Design Intern"
      };
      var newExperienceId = experienceRef.doc();
      var experienceData = {
        company : "Center for Technology and School Change – Teachers College, Columbia University",
        companyWebsite: "http://ctsc.tc.columbia.edu/",
        description: {
          0 : "Trained and supported K-12 educators in the implementation of project-based curriculum",
          1 : "Developed and documented standards-based, transdisciplinary projects for use in K-12 classrooms"
        },
        start_date: Date.parse("05/01/2018"),
        end_date: Date.parse("08/01/2019"),
        imageUrl: "http://ctsc.tc.columbia.edu/media/centers/ctsc/2018/ctsc-logo-contrast.png",
        role: "Professional Development Intern"
      };
      newExperienceId.set(experienceData);
      newExperienceId = experienceRef.doc();
      experienceData = {
        company : "Improving – Columbus",
        companyWebsite: "https://improving.com/location/columbus",
        description: {
          0 : "Collaborated with engineers, product managers, and other stakeholders to define, prioritize, and implement features",
          1 : "Created specifications, acceptance criteria, and test plans for SaaS product offerings",
          2 : "Facilitated Agile Scrum events and managed Agile Scrum backlog"
        },
        start_date: Date.parse("05/01/2018"),
        end_date: Date.parse("08/01/2019"),
        imageUrl: "https://image4.owler.com/logo/improving-enterprises_owler_20161215_113055_original.jpg",
        role: "Consultant II"
      };
      newExperienceId.set(experienceData);
      newExperienceId = experienceRef.doc();
      experienceData = {
        company : "Codemonster.io",
        companyWebsite: "http://codemonster.io/",
        description: {
          0 : "Taught computational thinking to children ages 8-12 using MIT’s educational programs Scratch and AppInventor",
          1 : "Assessed student needs and engagement to adapt and modify curriculum"
        },
        start_date: Date.parse("05/01/2018"),
        end_date: Date.parse("08/01/2019"),
        imageUrl: "http://www.codemonster.io/wp-content/uploads/2016/08/slider-monster-green.jpg",
        role: "Instructor"
      };
      newExperienceId.set(experienceData);
      newExperienceId = experienceRef.doc();
      experienceData = {
        company : "CoMIRA Solutions",
        companyWebsite: "https://comira-inc.com/",
        description: {
          0 : "Collaborated with product manager and engineering team to develop solutions for programming of an Ethernet receiver"
        },
        start_date: Date.parse("05/01/2018"),
        end_date: Date.parse("08/01/2019"),
        imageUrl: "https://25gethernet.org/sites/default/files/CoMira_Logo_PNG.png",
        role: "Hardware Engineering Intern"
      };
      newExperienceId.set(experienceData);
      newExperienceId = experienceRef.doc();
      experienceData = {
        company : "Qualcomm",
        companyWebsite: "http://qualcomm.com/",
        description: {
          0 : "Led a team to rank top 10 in an intern competition with a concept for a GPS-based traffic light system"
        },
        start_date: Date.parse("05/01/2018"),
        end_date: Date.parse("08/01/2019"),
        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRZwTQCu9DBTlK0c77f3EhZxFACXmnGnLwzmkb3V8IR5j0eNxBo",
        role: "Software Engineering Intern"
      };
      newExperienceId.set(experienceData);
    }


    function timeConverter(UNIX_timestamp){
      var a = new Date(UNIX_timestamp.seconds *1000);
      var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      var year = a.getFullYear();
      var month = months[a.getMonth()];
      var date = a.getDate();
      var hour = a.getHours();
      var min = a.getMinutes();
      var sec = a.getSeconds();
      var time = month + ' \'' + year.toString().substr(-2);
      return time;
    }

  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</app>
