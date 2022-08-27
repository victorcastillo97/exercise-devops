def build_images(def config) {
    withEnv(config) {
        sh 'make build.image.app'
        sh 'make build.image.bd'
        sh 'make build.image.proxy'
    }
}

def push_images_to_ecr(def config) {
    withEnv(config) {
        sh 'make ecr.login'
        sh 'make ecr.push.app'
        sh 'make ecr.push.bd'
        sh 'make ecr.push.proxy'
    }
}

def destroy_images_from_ecr(def config) {
    withEnv(config) {
        sh 'make ecr.login'
        sh 'make ecr.destroy.images'
    }
}

def stack_deploy(def config) {
    withEnv(config) {
        sh 'make up'
    }
}

def stack_destroy(def config) {
    withEnv(config) {
        sh 'make down'
    }
}

def configs() {
  def config = [
    "LC_CTYPE=en_US.UTF-8"
  ]
  return config
}

return this