# File: object_detection_demo_ssd_async.sh
# 2019/07/19	henry1758f 0.0.1	First Create

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo/GNA/openvinotoolkit/2018_R3/models_contrib/GNA
export MODEL_LOC_ORG=$HOME/openvino_models/models/SYNNEX_demo
function banner_show()
{
	echo "|=========================================|"
	echo "|             Speech Sample               |"
	echo "|=========================================|"
}
function download_GNA()
{
	wget -r -N -np -nH -P ${MODEL_LOC_ORG}/GNA https://download.01.org/openvinotoolkit/2018_R3/models_contrib/GNA/
}
function file_ckeck()
{
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/feat1_10.ark && echo " > rm_cnn4a_smbr/feat1_10.ark....(Checked!)" || ( echo "  > rm_cnn4a_smbr/feat1_10.ark....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/rm_cnn4a.bin && echo " > rm_cnn4a_smbr/rm_cnn4a.bin....(Checked!)" || ( echo "  > rm_cnn4a_smbr/rm_cnn4a.bin....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/rm_cnn4a.counts && echo " > rm_cnn4a_smbr/rm_cnn4a.counts....(Checked!)" || ( echo "  > rm_cnn4a_smbr/rm_cnn4a.counts....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/rm_cnn4a.mapping && echo " > rm_cnn4a_smbr/rm_cnn4a.mapping....(Checked!)" || ( echo "  > rm_cnn4a_smbr/rm_cnn4a.mapping....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/rm_cnn4a.md && echo " > rm_cnn4a_smbr/rm_cnn4a.md....(Checked!)" || ( echo "  > rm_cnn4a_smbr/rm_cnn4a.md....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/rm_cnn4a.nnet && echo " > rm_cnn4a_smbr/rm_cnn4a.nnet....(Checked!)" || ( echo "  > rm_cnn4a_smbr/rm_cnn4a.nnet....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/rm_cnn4a.xml && echo " > rm_cnn4a_smbr/rm_cnn4a.xml....(Checked!)" || ( echo "  > rm_cnn4a_smbr/rm_cnn4a.xml....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_cnn4a_smbr/score1_10.ark && echo " > rm_cnn4a_smbr/score1_10.ark....(Checked!)" || ( echo "  > rm_cnn4a_smbr/score1_10.ark....[LOST !]" && download_GNA )

	test -e ${MODEL_LOC}/rm_lstm4f/rm_lstm4f.bin && echo " > rm_lstm4f/rm_lstm4f.bin....(Checked!)" || ( echo "  > rm_lstm4f/rm_lstm4f.bin....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/rm_lstm4f.counts && echo " > rm_lstm4f/rm_lstm4f.counts....(Checked!)" || ( echo "  > rm_lstm4f/rm_lstm4f.counts....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/rm_lstm4f.mapping && echo " > rm_lstm4f/rm_lstm4f.mapping....(Checked!)" || ( echo "  > rm_lstm4f/rm_lstm4f.mapping....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/rm_lstm4f.md && echo " > rm_lstm4f/rm_lstm4f.md....(Checked!)" || ( echo "  > rm_lstm4f/rm_lstm4f.md....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/rm_lstm4f.nnet && echo " > rm_lstm4f/rm_lstm4f.nnet....(Checked!)" || ( echo "  > rm_lstm4f/rm_lstm4f.nnet....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/rm_lstm4f.xml && echo " > rm_lstm4f/rm_lstm4f.xml....(Checked!)" || ( echo "  > rm_lstm4f/rm_lstm4f.xml....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/test_feat_1_10.ark && echo " > rm_lstm4f/test_feat_1_10.ark....(Checked!)" || ( echo "  > rm_lstm4f/test_feat_1_10.ark....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/rm_lstm4f/test_score_1_10.ark && echo " > rm_lstm4f/test_score_1_10.ark....(Checked!)" || ( echo "  > rm_lstm4f/test_score_1_10.ark....[LOST !]" && download_GNA )

	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/dev93_10.ark && echo " > wsj_dnn5b_smbr/dev93_10.ark....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/dev93_10.ark....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/dev93_scores_10.ark && echo " > wsj_dnn5b_smbr/dev93_scores_10.ark....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/dev93_scores_10.ark....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/wsj_dnn5b.bin && echo " > wsj_dnn5b_smbr/wsj_dnn5b.bin....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/wsj_dnn5b.bin....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/wsj_dnn5b.counts && echo " > wsj_dnn5b_smbr/wsj_dnn5b.counts....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/wsj_dnn5b.counts....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/wsj_dnn5b.mapping && echo " > wsj_dnn5b_smbr/wsj_dnn5b.mapping....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/wsj_dnn5b.mapping....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/wsj_dnn5b.md && echo " > wsj_dnn5b_smbr/wsj_dnn5b.md....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/wsj_dnn5b.md....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/wsj_dnn5b.nnet && echo " > wsj_dnn5b_smbr/wsj_dnn5b.nnet....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/wsj_dnn5b.nnet....[LOST !]" && download_GNA )
	test -e ${MODEL_LOC}/wsj_dnn5b_smbr/wsj_dnn5b.xml && echo " > wsj_dnn5b_smbr/wsj_dnn5b.xml....(Checked!)" || ( echo "  > wsj_dnn5b_smbr/wsj_dnn5b.xml....[LOST !]" && download_GNA )
	test -e $HOME/kaldi/README.md || echo " Downloaded Kaldi...."
	test -e $HOME/kaldi/README.md || mkdir $HOME/kaldi
	test -e $HOME/kaldi/tools/extras/check_dependencies.sh || git clone https://github.com/kaldi-asr/kaldi.git $HOME/kaldi/
	test -e $HOME/kaldi/tools/extras/check_dependencies.sh &&  $HOME/kaldi/tools/extras/check_dependencies.sh && cd $HOME/kaldi/tools && make 


}


clear
banner_show
file_ckeck