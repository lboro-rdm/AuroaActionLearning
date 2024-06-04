library(shiny)
library(bslib)
library(shinythemes)

# Define UI for application
ui <- fluidPage(theme = shinytheme("lumen"),
  titlePanel("Action Learning Bot"),
  
  p("Welcome to the Action Learning Bot!"),
  p("Take a moment for yourself. Block out your calendar and close your email."),
  p("Spend a few minutes journaling about each question. Even if a question seems irrelevant, it might spark unexpected insights."),
  p("Embrace the journey of discovery and enjoy the process!"),
  
  sidebarLayout(
    sidebarPanel(
      p("Click the button below to get a new question."),
      actionButton("showImage", "Question"),
      p(),
      p("This bot was created by Lara Skelly (Loughborough University). The code is shared on ", a("GitHub", href = "https://github.com/lboro-rdm/AuroaActionLearning.git"), " under a CC-BY-NC licence."),
      p(),
      p("It was created with the questions which were part of the ", a("AdvancedHE Aurora programme.", href = "https://www.advance-he.ac.uk/programmes-events/developing-leadership/aurora"))
    ),
    mainPanel(
      imageOutput("randomImage")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Path to the image directory
  img_path <- "images/"
  
  # List all images in the directory
  img_files <- list.files(img_path, full.names = TRUE)
  
  # Initial image
  initial_img <- paste0(img_path, "pic1.jpg")

  # Reactive value to store the selected image
  selected_img <- reactiveVal(initial_img)
  
  # Observe the button click event
  observeEvent(input$showImage, {
    # Select a random image
    random_img <- sample(img_files, 1)
    selected_img(random_img)
  })
  
  # Render the selected image
  output$randomImage <- renderImage({
    if (is.null(selected_img())) {
      return(NULL)
    } else {
      list(src = selected_img(), alt = "Random Image", width = "100%")
    }
  }, deleteFile = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)
