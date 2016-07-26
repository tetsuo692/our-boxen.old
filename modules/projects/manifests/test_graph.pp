class projects::test_graph {
  boxen::project { 'test_graph':
	nginx => true,
    source  => 'tetsuo692/test_graph',
  }
}